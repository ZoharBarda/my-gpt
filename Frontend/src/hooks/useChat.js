import { useCallback, useRef, useState } from "react";
import { createConversation, sendMessage } from "../api/chatApi";

/**
 * Chat state. Lives in App so the conversation survives navigating to the About page.
 * The conversation is created lazily on the first message.
 */
export function useChat() {
  const [messages, setMessages] = useState([]);
  const [loading, setLoading] = useState(false);
  const [error, setError] = useState("");
  const conversationId = useRef(null);
  // Incremented on "new chat" so a late response from the old chat is ignored
  const session = useRef(0);

  const send = useCallback(async (text) => {
    const currentSession = session.current;
    setError("");
    setLoading(true);

    const pendingId = `pending-${Date.now()}`;
    setMessages((prev) => [...prev, { id: pendingId, role: "user", content: text }]);

    try {
      if (conversationId.current === null) {
        const conversation = await createConversation();
        if (currentSession !== session.current) return false;
        conversationId.current = conversation.id;
      }
      const { user_message, assistant_message } = await sendMessage(conversationId.current, text);
      if (currentSession !== session.current) return false;
      setMessages((prev) => [
        ...prev.filter((m) => m.id !== pendingId),
        user_message,
        assistant_message,
      ]);
      return true;
    } catch (err) {
      if (currentSession === session.current) {
        setMessages((prev) => prev.filter((m) => m.id !== pendingId));
        setError(err.message);
      }
      return false;
    } finally {
      if (currentSession === session.current) setLoading(false);
    }
  }, []);

  const newChat = useCallback(() => {
    session.current += 1;
    conversationId.current = null;
    setMessages([]);
    setError("");
    setLoading(false);
  }, []);

  return { messages, loading, error, send, newChat };
}
