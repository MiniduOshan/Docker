# 🚀 Full Guide: Dockerised MERN App (Vite + Express + MongoDB + Nodemon)

This repository provides a **full-stack MERN application** scaffold using:
- **MongoDB** as the database
- **Express.js** for the backend server
- **React (Vite)** for the frontend UI
- **Node.js** with **Nodemon** for backend auto-reloading
- **Docker** and **Docker Compose** for containerization

---

## 📁 Folder Structure

```
mern-app/
├── backend/
│   ├── Dockerfile
│   ├── package.json
│   ├── server.js
│   └── .dockerignore
│
├── frontend/
│   ├── Dockerfile
│   ├── package.json
│   ├── vite.config.js
│   ├── src/
│   └── public/
│
├── docker-compose.yml
└── README.md
```

---

## 🔧 Step-by-Step Setup Instructions

### 1. 🧱 Backend Setup (Express + Nodemon)

- Inside `backend/`, create `package.json` and install dependencies:

```bash
npm init -y
npm install express mongoose
npm install --save-dev nodemon
```

- `server.js`

```js
const express = require("express");
const mongoose = require("mongoose");

const app = express();
app.use(express.json());

mongoose
  .connect("mongodb://mongo:27017/mern_db")
  .then(() => console.log("✅ MongoDB Connected"))
  .catch((err) => console.error(err));

app.get("/", (req, res) => {
  res.send("🚀 MERN Backend running in Docker!");
});

app.listen(5000, () => console.log("✅ Server on http://localhost:5000"));
```

- `Dockerfile`

```dockerfile
FROM node:18

WORKDIR /app

COPY package*.json ./

RUN npm install && npm install -g nodemon

COPY . .

EXPOSE 5000

CMD ["npm", "start"]
```

- `.dockerignore`

```
node_modules
npm-debug.log
Dockerfile
.dockerignore
.git
.gitignore
```

---

### 2. 🎨 Frontend Setup (React + Vite)

- Inside `frontend/`, set up Vite app:

```bash
npm create vite@latest . -- --template react
npm install
```

- `vite.config.js`

```js
import { defineConfig } from "vite";
import react from "@vitejs/plugin-react";

export default defineConfig({
  plugins: [react()],
  server: {
    host: true,
    port: 3000
  }
});
```

- `Dockerfile`

```dockerfile
FROM node:18

WORKDIR /app

COPY package*.json ./

RUN npm install

COPY . .

EXPOSE 3000

CMD ["npm", "run", "dev"]
```

---

### 3. 🐳 Docker Compose Configuration

- `docker-compose.yml`

```yaml
version: "3.8"

services:
  mongo:
    image: mongo:6
    container_name: mongo
    ports:
      - "27017:27017"
    volumes:
      - mongo-data:/data/db

  backend:
    build: ./backend
    container_name: backend
    ports:
      - "5000:5000"
    volumes:
      - ./backend:/app
      - /app/node_modules
    depends_on:
      - mongo

  frontend:
    build: ./frontend
    container_name: frontend
    ports:
      - "3000:3000"
    volumes:
      - ./frontend:/app
      - /app/node_modules
    depends_on:
      - backend

volumes:
  mongo-data:
```

---

## ▶️ Running the App

```bash
docker-compose up --build   # Build and start all services
docker-compose up -d        # Start in detached mode
docker-compose down         # Stop and remove all containers, networks, volumes
```

---

## 🌐 Access the App

- Frontend: [http://localhost:3000](http://localhost:3000)
- Backend: [http://localhost:5000](http://localhost:5000)
- MongoDB: Internal Docker network as `mongo:27017`

---

## 🧪 Developer Tips

### Hot Reload (Frontend)
Vite supports hot reload out of the box.

### Auto-Restart (Backend)
Nodemon restarts the backend when code changes.

---

## 🔍 Useful Docker Commands

```bash
docker ps             # View running containers
docker ps -a          # View all containers
docker stop <id>      # Stop a container
docker rm <id>        # Remove a container
docker rmi <img>      # Remove image
docker system prune   # Clean up unused resources
```

---

