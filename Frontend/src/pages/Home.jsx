import ChatWindow from "../components/ChatWindow.jsx";

export default function Home({ chat }) {
  return (
    <ChatWindow
      messages={chat.messages}
      loading={chat.loading}
      error={chat.error}
      onSend={chat.send}
      onNewChat={chat.newChat}
    />
  );
}
