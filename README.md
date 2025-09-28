# 🚀 Docker Usage Guide with Nodemon

This guide explains how to build, run, and manage a **Node.js app inside Docker** with **Nodemon** for auto-reload.

---

## 📂 Project Structure

Your project should look like this:

```
.
├── Dockerfile
├── package.json
├── server.js
├── .dockerignore
└── README.md
```

---

## 📦 Example `package.json`

Here’s a sample `package.json` with **Express** and **Nodemon**:

```json
{
  "name": "docker-nodemon-app",
  "version": "1.0.0",
  "description": "A simple Node.js app running in Docker with nodemon",
  "main": "server.js",
  "scripts": {
    "start": "nodemon server.js"
  },
  "dependencies": {
    "express": "^4.18.2"
  },
  "devDependencies": {
    "nodemon": "^3.1.0"
  }
}
```

Install dependencies locally (optional):

```bash
npm install
```

---

## 🖥 Example `server.js`

A simple Express server:

```js
const express = require("express");
const app = express();

app.get("/", (req, res) => {
  res.send("🚀 Docker + Nodemon is working!");
});

app.listen(3000, () => {
  console.log("Server running on http://localhost:3000");
});
```

---

## 🐳 Dockerfile

```dockerfile
# Use official Node.js image
FROM node:18

# Set working directory
WORKDIR /app

# Copy package.json and package-lock.json first
COPY package*.json ./

# Install dependencies
RUN npm install

# Install nodemon globally
RUN npm install -g nodemon

# Copy the rest of the app
COPY . .

# Expose port (app runs on 3000)
EXPOSE 3000

# Run the app with nodemon
CMD ["nodemon", "server.js"]
```

---

## 🚫 .dockerignore

Prevent unnecessary files from being copied into Docker:

```
node_modules
npm-debug.log
Dockerfile
.dockerignore
.git
.gitignore
*.md
```

---

## 🐳 Build Docker Image

Build the image:

```bash
docker build -t test-docker .
```

Rebuild with a second version (using nodemon):

```bash
docker build -t test-docker2 .
```

---

## ▶️ Run Docker Container

Run the container normally:

```bash
docker run test-docker
```

Run with a custom name:

```bash
docker run --name test-docker test-docker
```

Run with **nodemon + live reload** (volumes mounted):

```bash
docker run --name test-container --rm -p 3000:3000 -v /app/node_modules -v ${PWD}:/app test-docker2
```

👉 Open: [http://localhost:3000](http://localhost:3000)

---

## 🔍 Check Running Containers

List running containers:

```bash
docker ps
```

List all containers (including stopped):

```bash
docker ps -a
```

---

## 🧹 Cleanup (Optional)

Stop a container:

```bash
docker stop <container_id>
```

Remove a container:

```bash
docker rm <container_id>
```

Remove an image:

```bash
docker rmi test-docker
```

Remove unused resources:

```bash
docker system prune -a
```

---

## 📝 Notes

* Default working directory inside container: `/app`  
* Replace `test-docker` or `test-docker2` with your own names  
* With `nodemon`, any code changes restart the server automatically  
