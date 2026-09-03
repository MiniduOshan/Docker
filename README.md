# 🚀 Dockerised MERN Stack Application

A complete **MERN stack application** containerised using **Docker** and **Docker Compose**.

This project demonstrates how to run a modern full-stack JavaScript application with:

* ⚛️ React + Vite
* 🟢 Node.js
* 🚂 Express.js
* 🍃 MongoDB
* 🐳 Docker
* 🐙 Docker Compose
* 🔄 Nodemon for backend development
* 💾 Persistent MongoDB storage

The entire application can be started with a single Docker Compose command.

---

## 📌 Table of Contents

* [Architecture](#-architecture)
* [Technology Stack](#-technology-stack)
* [Project Structure](#-project-structure)
* [Prerequisites](#-prerequisites)
* [Getting Started](#-getting-started)
* [Backend Setup](#-backend-setup)
* [Frontend Setup](#-frontend-setup)
* [Docker Configuration](#-docker-configuration)
* [Docker Compose](#-docker-compose)
* [Running the Application](#-running-the-application)
* [Accessing the Application](#-accessing-the-application)
* [Environment Variables](#-environment-variables)
* [Development Workflow](#-development-workflow)
* [Useful Docker Commands](#-useful-docker-commands)
* [MongoDB Persistence](#-mongodb-persistence)
* [Troubleshooting](#-troubleshooting)
* [Production Considerations](#-production-considerations)
* [Future Improvements](#-future-improvements)
* [License](#-license)

---

# 🏗️ Architecture

The application consists of three main services:

```text
                    ┌──────────────────────┐
                    │       Browser        │
                    └──────────┬───────────┘
                               │
                               │ :3000
                               ▼
                    ┌──────────────────────┐
                    │   React + Vite       │
                    │     Frontend         │
                    └──────────┬───────────┘
                               │
                               │ API Requests
                               ▼
                    ┌──────────────────────┐
                    │   Node.js + Express  │
                    │      Backend         │
                    └──────────┬───────────┘
                               │
                               │ MongoDB
                               ▼
                    ┌──────────────────────┐
                    │       MongoDB        │
                    │      Database        │
                    └──────────────────────┘
```

Docker Compose creates an internal network where services can communicate using their service names.

For example, the backend connects to MongoDB using:

```text
mongodb://mongo:27017/mern_db
```

The hostname `mongo` refers to the MongoDB service defined in `docker-compose.yml`.

---

# 🧰 Technology Stack

| Technology     | Purpose                                    |
| -------------- | ------------------------------------------ |
| React          | Frontend UI                                |
| Vite           | Frontend build tool and development server |
| Node.js        | JavaScript runtime                         |
| Express.js     | Backend API framework                      |
| MongoDB        | NoSQL database                             |
| Mongoose       | MongoDB ODM                                |
| Nodemon        | Backend development auto-reload            |
| Docker         | Application containerization               |
| Docker Compose | Multi-container orchestration              |

---

# 📁 Project Structure

```text
mern-app/
│
├── backend/
│   ├── Dockerfile
│   ├── .dockerignore
│   ├── package.json
│   ├── package-lock.json
│   └── server.js
│
├── frontend/
│   ├── Dockerfile
│   ├── .dockerignore
│   ├── package.json
│   ├── package-lock.json
│   ├── vite.config.js
│   ├── index.html
│   │
│   ├── public/
│   │
│   └── src/
│       ├── App.jsx
│       ├── main.jsx
│       └── ...
│
├── docker-compose.yml
├── .gitignore
└── README.md
```

---

# 📋 Prerequisites

Before starting, make sure you have the following installed:

### 1. Node.js

Download and install Node.js from:

[Node.js](https://nodejs.org/?utm_source=chatgpt.com)

Check the installation:

```bash
node --version
npm --version
```

### 2. Docker

Install Docker Desktop:

[Docker](https://www.docker.com/?utm_source=chatgpt.com)

Verify:

```bash
docker --version
```

### 3. Docker Compose

Modern Docker Desktop includes Docker Compose.

Check:

```bash
docker compose version
```

> **Note:** Modern Docker uses `docker compose` instead of the older `docker-compose` command.

---

# 🚀 Getting Started

Clone the repository:

```bash
git clone <your-repository-url>
```

Navigate into the project:

```bash
cd mern-app
```

Build and start all services:

```bash
docker compose up --build
```

Docker will:

1. Build the backend image
2. Build the frontend image
3. Pull the MongoDB image
4. Create the Docker network
5. Create the MongoDB volume
6. Start MongoDB
7. Start the backend
8. Start the frontend

---

# 🟢 Backend Setup

Navigate into the backend directory:

```bash
cd backend
```

Initialise the Node.js project:

```bash
npm init -y
```

Install dependencies:

```bash
npm install express mongoose
```

Install Nodemon:

```bash
npm install --save-dev nodemon
```

---

## Backend `package.json`

Make sure the scripts contain:

```json
{
  "scripts": {
    "start": "nodemon server.js"
  }
}
```

---

## Backend `server.js`

```javascript
const express = require("express");
const mongoose = require("mongoose");

const app = express();

app.use(express.json());

const PORT = 5000;
const MONGO_URI = "mongodb://mongo:27017/mern_db";

mongoose
  .connect(MONGO_URI)
  .then(() => {
    console.log("✅ MongoDB Connected");
  })
  .catch((error) => {
    console.error("❌ MongoDB Connection Error:", error);
  });

app.get("/", (req, res) => {
  res.json({
    message: "🚀 MERN Backend running in Docker!",
  });
});

app.listen(PORT, "0.0.0.0", () => {
  console.log(`✅ Server running on port ${PORT}`);
});
```

---

# 🐳 Backend Dockerfile

Create:

```text
backend/Dockerfile
```

```dockerfile
FROM node:18

WORKDIR /app

COPY package*.json ./

RUN npm install

COPY . .

EXPOSE 5000

CMD ["npm", "start"]
```

---

# 🚫 Backend `.dockerignore`

Create:

```text
backend/.dockerignore
```

```text
node_modules
npm-debug.log
Dockerfile
.dockerignore
.git
.gitignore
.env
```

---

# ⚛️ Frontend Setup

Create the Vite React application:

```bash
cd frontend
```

If the directory is empty:

```bash
npm create vite@latest . -- --template react
```

Install dependencies:

```bash
npm install
```

---

# ⚙️ Vite Configuration

Create/update:

```text
frontend/vite.config.js
```

```javascript
import { defineConfig } from "vite";
import react from "@vitejs/plugin-react";

export default defineConfig({
  plugins: [react()],
  server: {
    host: "0.0.0.0",
    port: 3000,
  },
});
```

The important part for Docker is:

```javascript
host: "0.0.0.0"
```

This allows the Vite development server to accept connections from outside the container.

---

# 🐳 Frontend Dockerfile

Create:

```text
frontend/Dockerfile
```

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

# 🚫 Frontend `.dockerignore`

Create:

```text
frontend/.dockerignore
```

```text
node_modules
npm-debug.log
Dockerfile
.dockerignore
.git
.gitignore
.env
dist
```

---

# 🐙 Docker Compose

Create the following file in the project root:

```text
docker-compose.yml
```

```yaml
services:

  # -------------------------
  # MongoDB
  # -------------------------
  mongo:
    image: mongo:6
    container_name: mongo
    restart: unless-stopped

    ports:
      - "27017:27017"

    volumes:
      - mongo-data:/data/db


  # -------------------------
  # Backend
  # -------------------------
  backend:
    build: ./backend
    container_name: backend
    restart: unless-stopped

    ports:
      - "5000:5000"

    volumes:
      - ./backend:/app
      - /app/node_modules

    depends_on:
      - mongo


  # -------------------------
  # Frontend
  # -------------------------
  frontend:
    build: ./frontend
    container_name: frontend
    restart: unless-stopped

    ports:
      - "3000:3000"

    volumes:
      - ./frontend:/app
      - /app/node_modules

    depends_on:
      - backend


# -------------------------
# Persistent Volumes
# -------------------------
volumes:
  mongo-data:
```

---

# 🔗 Docker Service Communication

One of the most important concepts in Docker Compose is service-to-service communication.

The services are:

```text
mongo
backend
frontend
```

Inside the Docker network, the backend can access MongoDB using:

```text
mongodb://mongo:27017/mern_db
```

Do **not** use:

```text
mongodb://localhost:27017/mern_db
```

for the backend's MongoDB connection when both are running in separate containers.

Why?

Inside the backend container:

```text
localhost
```

means:

```text
backend container
```

not the MongoDB container.

Docker Compose provides DNS resolution so:

```text
mongo
```

automatically points to the MongoDB container.

---

# ▶️ Running the Application

## Build and Start

```bash
docker compose up --build
```

---

## Start in Background

```bash
docker compose up -d
```

---

## Rebuild Containers

```bash
docker compose up --build
```

---

## Stop Containers

```bash
docker compose stop
```

---

## Stop and Remove Containers

```bash
docker compose down
```

---

## Stop and Remove Containers + Volumes

⚠️ This deletes the MongoDB data stored in the Compose volume.

```bash
docker compose down -v
```

---

# 🌐 Access the Application

After starting the application:

### Frontend

```text
http://localhost:3000
```

### Backend

```text
http://localhost:5000
```

### MongoDB

From the host:

```text
mongodb://localhost:27017
```

From the backend container:

```text
mongodb://mongo:27017/mern_db
```

---

# 🔍 Useful Docker Commands

## View Running Containers

```bash
docker ps
```

---

## View All Containers

```bash
docker ps -a
```

---

## View Images

```bash
docker images
```

---

## View Docker Networks

```bash
docker network ls
```

---

## View Volumes

```bash
docker volume ls
```

---

## View Container Logs

Backend:

```bash
docker logs backend
```

Frontend:

```bash
docker logs frontend
```

MongoDB:

```bash
docker logs mongo
```

---

## Follow Logs

```bash
docker logs -f backend
```

---

## Execute Commands Inside a Container

Backend:

```bash
docker exec -it backend sh
```

MongoDB:

```bash
docker exec -it mongo mongosh
```

---

## Stop a Container

```bash
docker stop <container_id>
```

---

## Remove a Container

```bash
docker rm <container_id>
```

---

## Remove an Image

```bash
docker rmi <image_id>
```

---

## Clean Unused Docker Resources

```bash
docker system prune
```

To remove unused volumes as well:

```bash
docker system prune --volumes
```

⚠️ Use this carefully because unused resources may contain data you still need.

---

# 💾 MongoDB Persistence

MongoDB uses a named Docker volume:

```yaml
volumes:
  - mongo-data:/data/db
```

The volume is defined at the bottom of `docker-compose.yml`:

```yaml
volumes:
  mongo-data:
```

This means MongoDB data survives container recreation.

For example:

```bash
docker compose down
```

does **not** delete the MongoDB volume.

Starting the application again:

```bash
docker compose up -d
```

will reuse the existing MongoDB data.

However:

```bash
docker compose down -v
```

removes the volume and therefore deletes the stored MongoDB data.

---

# 🔄 Hot Reloading

This project is configured for development.

The backend mounts:

```yaml
volumes:
  - ./backend:/app
  - /app/node_modules
```

The frontend mounts:

```yaml
volumes:
  - ./frontend:/app
  - /app/node_modules
```

This allows files on your host machine to be synchronized with the containers.

### Backend

Nodemon automatically restarts the server when files change.

### Frontend

Vite automatically updates the application when React files change.

Therefore, you can edit:

```text
frontend/src/App.jsx
```

or:

```text
backend/server.js
```

without manually rebuilding the containers for every code change.

---

# 🔐 Environment Variables

For a real application, MongoDB credentials and configuration should not be hardcoded.

Instead of:

```javascript
const MONGO_URI = "mongodb://mongo:27017/mern_db";
```

use:

```javascript
const MONGO_URI = process.env.MONGO_URI;
```

Then create:

```text
backend/.env
```

Example:

```env
PORT=5000
MONGO_URI=mongodb://mongo:27017/mern_db
```

For production, use a secured MongoDB connection string.

Never commit sensitive `.env` files to Git.

Add this to `.gitignore`:

```text
.env
.env.*
!.env.example
```

---

# 🧪 Testing the Backend

After starting the containers, open:

```text
http://localhost:5000
```

You should receive:

```json
{
  "message": "🚀 MERN Backend running in Docker!"
}
```

You can also test the API using tools such as Postman or curl.

Example:

```bash
curl http://localhost:5000
```

---

# 🛠️ Troubleshooting

## 1. Port Already in Use

If you see an error such as:

```text
port is already allocated
```

check which process is using the port.

Windows:

```powershell
netstat -ano | findstr :3000
```

or:

```powershell
netstat -ano | findstr :5000
```

You can either stop the process or change the port mapping.

For example:

```yaml
ports:
  - "3001:3000"
```

The application would then be accessible at:

```text
http://localhost:3001
```

---

## 2. Frontend Cannot Be Accessed

Make sure Vite is configured with:

```javascript
server: {
  host: "0.0.0.0",
  port: 3000
}
```

Without `host: "0.0.0.0"`, the development server may only listen inside the container.

---

## 3. Backend Cannot Connect to MongoDB

Check MongoDB:

```bash
docker ps
```

Then check its logs:

```bash
docker logs mongo
```

Check backend logs:

```bash
docker logs backend
```

Make sure the connection string uses:

```text
mongodb://mongo:27017/mern_db
```

and not:

```text
mongodb://localhost:27017/mern_db
```

---

## 4. Changes Are Not Updating

Restart the services:

```bash
docker compose restart
```

If necessary, rebuild:

```bash
docker compose down
docker compose up --build
```

---

## 5. `node_modules` Problems

If dependencies become corrupted, remove the containers and rebuild:

```bash
docker compose down
docker compose build --no-cache
docker compose up
```

---

## 6. MongoDB Data Disappeared

Check whether the volume exists:

```bash
docker volume ls
```

Avoid using:

```bash
docker compose down -v
```

unless you intentionally want to delete MongoDB data.

---

# 📦 Development vs Production

This repository is primarily configured for **development**.

The frontend currently runs:

```bash
npm run dev
```

and the backend uses:

```bash
nodemon
```

This is convenient during development but is not the ideal production setup.

---

# 🚀 Production Architecture

For production, a more appropriate architecture would be:

```text
                    Internet
                       │
                       ▼
                ┌───────────────┐
                │    Nginx      │
                │ Reverse Proxy │
                └───────┬───────┘
                        │
              ┌─────────┴─────────┐
              │                   │
              ▼                   ▼
        React Static         Express API
        Production Build       Backend
              │                   │
              │                   ▼
              │              MongoDB
              │
              ▼
           Browser
```

The React application should generally be built:

```bash
npm run build
```

and served as static files rather than running the Vite development server.

The backend should also run without Nodemon.

For example:

```json
{
  "scripts": {
    "start": "node server.js",
    "dev": "nodemon server.js"
  }
}
```

---

# 🔒 Production Security Checklist

Before deploying this application to production:

* [ ] Do not expose MongoDB publicly unless required
* [ ] Use environment variables for secrets
* [ ] Use strong MongoDB credentials
* [ ] Use HTTPS
* [ ] Use a reverse proxy such as Nginx
* [ ] Do not use Nodemon in production
* [ ] Build the React application for production
* [ ] Restrict exposed Docker ports
* [ ] Configure CORS properly
* [ ] Add API authentication where required
* [ ] Add request validation
* [ ] Add rate limiting
* [ ] Configure database backups
* [ ] Keep Docker images updated
* [ ] Do not commit `.env` files

---

# 🧹 Useful Docker Cleanup

Remove stopped containers:

```bash
docker container prune
```

Remove unused images:

```bash
docker image prune
```

Remove unused networks:

```bash
docker network prune
```

Remove unused volumes:

```bash
docker volume prune
```

Remove unused Docker resources:

```bash
docker system prune
```

For a more aggressive cleanup:

```bash
docker system prune -a
```

⚠️ Review what Docker plans to remove before using aggressive cleanup commands.

---

# 📊 Container Overview

After running:

```bash
docker compose up -d
```

you should have three containers:

| Container  | Technology        |    Port |
| ---------- | ----------------- | ------: |
| `frontend` | React + Vite      |  `3000` |
| `backend`  | Node.js + Express |  `5000` |
| `mongo`    | MongoDB           | `27017` |

The communication flow is:

```text
Browser
   │
   │ localhost:3000
   ▼
Frontend
   │
   │ API
   ▼
Backend
   │
   │ mongodb://mongo:27017
   ▼
MongoDB
```

---

# 🧠 Key Docker Concepts Demonstrated

This project is useful for learning several important Docker concepts.

### Containers

Each application component runs in its own container.

```text
Frontend → Container
Backend  → Container
MongoDB  → Container
```

### Images

Dockerfiles define how application images are built.

```text
Dockerfile → Docker Image → Container
```

### Volumes

Volumes provide persistent storage.

```text
MongoDB Container
       │
       ▼
mongo-data volume
```

### Networks

Docker Compose automatically creates a network allowing services to communicate.

```text
frontend ─────┐
              │
backend ──────┼── Docker Network
              │
mongo ────────┘
```

### Compose

Docker Compose manages multiple services together.

Instead of running:

```bash
docker run ...
docker run ...
docker run ...
```

you can run:

```bash
docker compose up
```

---

# 🔮 Future Improvements

This project can be extended with:

* 🔐 JWT authentication
* 👤 User registration and login
* 🍃 MongoDB models
* 🔌 REST API
* 📡 WebSockets
* 🧪 Automated testing
* 📦 Multi-stage Docker builds
* 🌐 Nginx reverse proxy
* 🔒 HTTPS with SSL
* 🚀 CI/CD with GitHub Actions
* ☁️ Cloud deployment
* 📊 Application monitoring
* 📝 API documentation with Swagger
* 🔑 Secret management
* 🗄️ MongoDB backup strategy
* ⚡ Redis caching

---

# 🚀 Quick Start

If everything is already configured, simply run:

```bash
git clone <your-repository-url>

cd mern-app

docker compose up --build
```

Then open:

```text
Frontend → http://localhost:3000
Backend  → http://localhost:5000
```

To stop:

```bash
docker compose down
```

---

# 📚 Learning Resources

For official documentation:

* [Docker Documentation](https://docs.docker.com/?utm_source=chatgpt.com)
* [Docker Compose Documentation](https://docs.docker.com/compose/?utm_source=chatgpt.com)
* [Node.js Documentation](https://nodejs.org/docs/latest/api/?utm_source=chatgpt.com)
* [Express.js Documentation](https://expressjs.com/?utm_source=chatgpt.com)
* [React Documentation](https://react.dev/?utm_source=chatgpt.com)
* [Vite Documentation](https://vite.dev/?utm_source=chatgpt.com)
* [MongoDB Documentation](https://www.mongodb.com/docs/?utm_source=chatgpt.com)
* [Mongoose Documentation](https://mongoosejs.com/docs/?utm_source=chatgpt.com)

---

# 🤝 Contributing

Contributions are welcome!

1. Fork the repository
2. Create a feature branch

```bash
git checkout -b feature/my-feature
```

3. Make your changes
4. Commit your changes

```bash
git commit -m "Add my feature"
```

5. Push the branch

```bash
git push origin feature/my-feature
```

6. Open a Pull Request

---

# 📄 License

This project is available under the MIT License.

You are free to use, modify, and distribute the project according to the terms of the license.

---

# ⭐ Support

If this project helped you understand how to Dockerise a MERN application, consider giving the repository a ⭐ on GitHub.

**Happy Coding! 🚀🐳**
