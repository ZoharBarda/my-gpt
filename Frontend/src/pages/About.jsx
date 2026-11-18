export default function About() {
  return (
    <section className="about">
      <h1>About</h1>

      <div className="card">
        <h2>The system</h2>
        <p>
          This is a ChatGPT-style web app. You can hold an ongoing conversation with a language
          model, and the chat answers with the full context of everything said so far. Every
          message is stored in a MySQL database, and the OpenAI API is only ever called from the
          server.
        </p>
        <ul>
          <li>Frontend: React + Vite + React Router</li>
          <li>Backend: Python FastAPI + SQLAlchemy</li>
          <li>Database: MySQL</li>
          <li>Model: OpenAI</li>
        </ul>
      </div>

      <div className="card">
        <h2>The developer</h2>
        <p>
          Hi, I'm <strong>Zohar Barda</strong>, a Python Full-Stack student at John Bryce. This
          project was built as part of the course.
        </p>
        <p className="muted">Replace this text with your own details (education, skills, contact).</p>
      </div>
    </section>
  );
}
