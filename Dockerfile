#Base image
FROM node:20-alpine

#Set working directory
WORKDIR /app

#Copy source code
COPY . .

#run the app
CMD ["node", "index.js"]


