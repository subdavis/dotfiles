/**
 * Re-registers the built-in bash tool with a custom call header:
 *   - "~" prefix instead of "$"
 *   - one line per top-level command (`;` / newline)
 *   - hanging indent for `&&` / `||` continuations
 *   - a leading `cd <session cwd> &&` is dropped as a no-op
 *
 * Display only. Execution and result rendering are the built-in ones:
 * createBashToolDefinition() returns the full ToolDefinition (execute,
 * renderCall, renderResult, prompt metadata), so spreading it and replacing
 * renderCall changes nothing else. createBashTool() would not work here, it
 * wraps the definition into an AgentTool and drops the renderers.
 */

import { homedir } from "node:os";
import { resolve } from "node:path";
import type { ExtensionAPI } from "@earendil-works/pi-coding-agent";
import { createBashToolDefinition } from "@earendil-works/pi-coding-agent";
import { Text } from "@earendil-works/pi-tui";

/** A display line: `op` set means it continues the previous line. */
type Segment = { op?: "&&" | "||"; text: string };

/**
 * Split a command into display segments on top-level `;`, newline, `&&` and `||`.
 * Quotes, backticks and (){} groups are respected. Heredocs and anything
 * degenerate are returned as a single verbatim segment.
 */
function splitCommand(command: string): Segment[] {
	if (/<<-?\s*['"]?\w/.test(command)) return [{ text: command }];

	const segments: Segment[] = [];
	let buf = "";
	let quote: string | undefined;
	let depth = 0;
	let op: Segment["op"];

	const push = (nextOp: Segment["op"]) => {
		segments.push({ op, text: buf.trim() });
		op = nextOp;
		buf = "";
	};

	for (let i = 0; i < command.length; i++) {
		const char = command[i];
		if (quote) {
			buf += char;
			if (char === quote) quote = undefined;
			continue;
		}
		if (char === '"' || char === "'" || char === "`") {
			quote = char;
			buf += char;
			continue;
		}
		if (char === "(" || char === "{") depth++;
		else if (char === ")" || char === "}") depth = Math.max(0, depth - 1);
		else if (depth === 0) {
			if (char === ";" || char === "\n") {
				push(undefined);
				continue;
			}
			if (command.startsWith("&&", i) || command.startsWith("||", i)) {
				push(command.slice(i, i + 2) as Segment["op"]);
				i++;
				continue;
			}
		}
		buf += char;
	}
	push(undefined);

	// An empty continuation means unbalanced operators (`foo &&`): render verbatim.
	if (segments.some((segment) => segment.op && !segment.text)) return [{ text: command }];
	return segments.filter((segment) => segment.text);
}

/**
 * Drop `cd <session cwd> &&` statement prefixes, which are no-ops. Runs on
 * segments because the `&&` is already split off by then: a matching `cd`
 * segment is removed and the segment it gated is promoted to a new line.
 */
function dropRedundantCd(segments: Segment[], cwd: string): Segment[] {
	return segments.filter((segment, i) => {
		const next = segments[i + 1];
		if (segment.op || next?.op !== "&&") return true;

		const match = /^cd\s+("[^"]+"|'[^']+'|\S+)$/.exec(segment.text);
		if (!match) return true;

		const dir = match[1].replace(/^["']|["']$/g, "").replace(/^~(?=\/|$)/, homedir());
		if (resolve(cwd, dir) !== resolve(cwd)) return true;

		next.op = undefined;
		return false;
	});
}

export default function (pi: ExtensionAPI) {
	const base = createBashToolDefinition(process.cwd());

	pi.registerTool({
		...base,
		renderCall(args, theme, context) {
			const command = typeof args?.command === "string" ? args.command : "";
			const lines = dropRedundantCd(splitCommand(command), context.cwd).map(({ op, text }) =>
				op
					? `    ${theme.fg("muted", `${op} `)}${theme.fg("toolTitle", theme.bold(text))}`
					: theme.fg("toolTitle", theme.bold(`~ ${text}`)),
			);
			if (lines.length === 0) {
				lines.push(theme.fg("toolTitle", theme.bold("~ ")) + theme.fg("toolOutput", "..."));
			}
			if (args?.timeout) lines[0] += theme.fg("muted", ` (timeout ${args.timeout}s)`);

			// Built-in renderResult reads state.startedAt for the elapsed/took footer.
			const state = context.state as { startedAt?: number; endedAt?: number };
			if (context.executionStarted && state.startedAt === undefined) {
				state.startedAt = Date.now();
				state.endedAt = undefined;
			}

			const text = (context.lastComponent as Text | undefined) ?? new Text("", 0, 0);
			text.setText(lines.join("\n"));
			return text;
		},
	});
}
