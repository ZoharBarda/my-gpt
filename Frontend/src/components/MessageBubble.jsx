export default function MessageBubble({ role, content }) {
  return (
    <div className={`row ${role}`}>
      <div className={`bubble ${role}`} dir="auto">
        {content}
      </div>
    </div>
  );
}
