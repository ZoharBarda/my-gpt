import { useEffect, useRef } from "react";
import MessageBubble from "./MessageBubble.jsx";
import MessageInput from "./MessageInput.jsx";

export default function ChatWindow({ messages, loading, error, onSend, onNewChat }) {
  const bottomRef = useRef(null);

  // Scroll to the latest message whenever something changes
  useEffect(() => {
    bottomRef.current?.scrollIntoView({ behavior: "smooth" });
  }, [messages, loading, error]);

  return (
    <section className="chat">
      <div className="chat-header">
        <h1>Chat</h1>
        <button type="button" className="secondary" onClick={onNewChat}>
          + New chat
        </button>
      </div>

      <div className="messages">
        {messages.length === 0 && !loading && (
          <div className="empty">
            <h2>How can I help you today?</h2>
            <p>Type a message below to start a conversation.</p>
          </div>
        )}
        {messages.map((m) => (
          <MessageBubble key={m.id} role={m.role} content={m.content} />
        ))}
        {loading && (
          <div className="row assistant">
            <div className="bubble assistant typing" aria-label="The chat is typing">
              <span />
              <span />
              <span />
            </div>
          </div>
        )}
        {error && (
          <div className="error" role="alert">
            {error}
          </div>
        )}
        <div ref={bottomRef} />
      </div>

      <MessageInput onSend={onSend} disabled={loading} />
    </section>
  );
}
