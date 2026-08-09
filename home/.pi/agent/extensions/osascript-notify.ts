/**
 * Fires a macOS desktop notification (via osascript) when the session
 * settles, i.e. it's done and waiting for user input.
 */
import { execFile } from "node:child_process";
import { promisify } from "node:util";
import type { ExtensionAPI } from "@earendil-works/pi-coding-agent";

const execFileAsync = promisify(execFile);

// Name of the frontmost app, as reported by System Events, must match this
// (case-insensitive) to be considered "focused". Ghostty reports as "ghostty".
const FOCUSED_APP_NAME = "ghostty";

function escapeForAppleScript(text: string): string {
  return text.replace(/\\/g, "\\\\").replace(/"/g, '\\"');
}

async function isTerminalFocused(): Promise<boolean> {
  try {
    const { stdout } = await execFileAsync("osascript", [
      "-e",
      'tell application "System Events" to name of first application process whose frontmost is true',
    ]);
    return stdout.trim().toLowerCase() === FOCUSED_APP_NAME;
  } catch {
    // If we can't tell, err on the side of notifying.
    return false;
  }
}

function notify(title: string, message: string): void {
  const script = `display notification "${escapeForAppleScript(message)}" with title "${escapeForAppleScript(title)}"`;
  execFile("osascript", ["-e", script], () => {});
}

export default function (pi: ExtensionAPI) {
  pi.on("agent_settled", async (_event, ctx) => {
    if (await isTerminalFocused()) return;
    notify("Pi", "Ready for input");
  });
}
