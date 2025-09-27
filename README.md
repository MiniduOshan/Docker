# Docker Usage Guide

This README explains how to build, run, and manage a Docker container using the provided commands.

---

## 🚀 Build the Docker Image

Build the image from the Dockerfile in the current directory:

```bash
docker build -t test-docker .
```

* `-t test-docker` → names the image as **test-docker**  
* `.` → points to the current directory containing the `Dockerfile`

---

## 📦 List Docker Images

Check all images available on your system:

```bash
docker images
```

---

## ▶️ Run the Docker Container

Run the container using the image:

```bash
docker run test-docker
```

Run with a specific container name:

```bash
docker run --name test-docker test-docker
```

---

## 🔍 Check Running Containers

List currently running containers:

```bash
docker ps
```

List all containers (including stopped ones):

```bash
docker ps -a
```

---

## 📝 Notes

* Replace `test-docker` with your preferred image/container name if needed.  
* Ensure you have Docker installed and running on your system.  
