import { useRef, useState } from "react";

export default function MessageInput({ onSend, disabled }) {
  const [text, setText] = useState("");
  const inputRef = useRef(null);
  const canSend = text.trim().length > 0 && !disabled;

  async function submit() {
    if (!canSend) return;
    const value = text.trim();
    setText("");
    const ok = await onSend(value);
    // Give the text back so a failed message isn't lost
    if (!ok) setText((current) => current || value);
    inputRef.current?.focus();
  }

  function handleKeyDown(e) {
    // Enter sends, Shift+Enter inserts a new line
    if (e.key === "Enter" && !e.shiftKey && !e.nativeEvent.isComposing) {
      e.preventDefault();
      submit();
    }
  }

  return (
    <div className="input-bar">
      <textarea
        ref={inputRef}
        dir="auto"
        rows={1}
        value={text}
        placeholder="Type a message..."
        maxLength={4000}
        onChange={(e) => setText(e.target.value)}
        onKeyDown={handleKeyDown}
      />
      <button type="button" onClick={submit} disabled={!canSend} aria-label="Send">
        Send
      </button>
    </div>
  );
}
