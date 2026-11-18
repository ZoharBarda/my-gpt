const API_URL = import.meta.env.VITE_API_URL || "http://localhost:8000";

const NETWORK_ERROR = "Can't reach the server. Please check your connection and try again.";

async function request(path, options) {
  let response;
  try {
    response = await fetch(`${API_URL}${path}`, {
      headers: { "Content-Type": "application/json" },
      ...options,
    });
  } catch {
    throw new Error(NETWORK_ERROR);
  }

  const data = await response.json().catch(() => null);
  if (!response.ok) {
    throw new Error(data?.detail || "Something went wrong. Please try again.");
  }
  return data;
}

export function createConversation() {
  return request("/api/conversations", { method: "POST" });
}

export function sendMessage(conversationId, content) {
  return request(`/api/conversations/${conversationId}/messages`, {
    method: "POST",
    body: JSON.stringify({ content }),
  });
}
