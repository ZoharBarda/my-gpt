import { Route, Routes } from "react-router-dom";
import Navbar from "./components/Navbar.jsx";
import About from "./pages/About.jsx";
import Home from "./pages/Home.jsx";
import { useChat } from "./hooks/useChat.js";

export default function App() {
  const chat = useChat();

  return (
    <div className="app">
      <Navbar />
      <main className="main">
        <Routes>
          <Route path="/" element={<Home chat={chat} />} />
          <Route path="/about" element={<About />} />
          <Route path="*" element={<Home chat={chat} />} />
        </Routes>
      </main>
    </div>
  );
}
