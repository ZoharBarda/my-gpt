import { NavLink } from "react-router-dom";

export default function Navbar() {
  return (
    <header className="navbar">
      <span className="brand">AI Chat</span>
      <nav>
        <NavLink to="/" end className={({ isActive }) => (isActive ? "link active" : "link")}>
          Home
        </NavLink>
        <NavLink to="/about" className={({ isActive }) => (isActive ? "link active" : "link")}>
          About
        </NavLink>
      </nav>
    </header>
  );
}
