# AI Chat

ChatGPT-style chat site. React (Vite) frontend, FastAPI backend, MySQL database, OpenAI on the server only.

```
Zohar Barda/
├─ Database/   schema.sql (create schema), chatdb_export.sql (full export)
├─ Backend/    FastAPI project + postman_collection.json
├─ Frontend/   React project
└─ docker-compose.yml   (optional local MySQL)
```

## API

| Method | Path | Description |
|---|---|---|
| POST | `/api/conversations` | Create a new conversation |
| POST | `/api/conversations/{id}/messages` | Body `{"content": "..."}`. Saves the message, sends the full history to OpenAI, saves and returns the reply |
| GET | `/api/conversations/{id}` | Fetch a conversation with all its messages |
| GET | `/api/health` | Health check |

Interactive docs: http://localhost:8000/docs

## 1. Database

**Option A – Docker (easiest)**
```
docker compose up -d
```
This starts MySQL 8 on port 3306 (root / `mypassword`, database `chatdb`) and runs `Database/schema.sql` on first start.

**Option B – local MySQL**
```
mysql -u root -p < Database/schema.sql
```
To load the submitted export (structure + data) instead: `mysql -u root -p < Database/chatdb_export.sql`

Schema: `conversations(id, created_at)` and `messages(id, conversation_id FK, role ENUM('user','assistant'), content, created_at)`.

## 2. Backend

```
cd Backend
python -m venv venv
venv\Scripts\activate          # macOS/Linux: source venv/bin/activate
pip install -r requirements.txt
copy .env.example .env         # macOS/Linux: cp .env.example .env
```
Edit `.env`: set `OPENAI_API_KEY` and the DB details (`DB_HOST`, `DB_USER`, `DB_PASSWORD`, `DB_NAME`). Then:
```
uvicorn main:app --reload
```
The API runs on http://localhost:8000. Import `Backend/postman_collection.json` into Postman to try the endpoints.

## 3. Frontend

```
cd Frontend
npm install
npm run dev
```
Open http://localhost:5173. If the API runs elsewhere, copy `.env.example` to `.env` and set `VITE_API_URL`.

## Notes
- The OpenAI key lives only in `Backend/.env` (git-ignored). Never put it in the frontend.
- Refreshing the page starts a fresh conversation (by design); old conversations remain in the database.
- If OpenAI fails or times out, the unanswered user message is removed, so the history stays consistent.
