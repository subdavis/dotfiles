import type { ExtensionAPI } from "@earendil-works/pi-coding-agent";

export default function (pi: ExtensionAPI) {
  const extraHeader = process.env.ANTHROPIC_CUSTOM_HEADERS;
  const headers: Record<string, string> = {}
  if (extraHeader) {
    const [key, value] = extraHeader.split(":");
    headers[key] = value.trim();
  }
  // Both baseUrl and headers
  pi.registerProvider("anthropic", {
    baseUrl: "https://api.portkey.ai",
    headers,
  });
}
