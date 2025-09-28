#Base image
FROM node:20-alpine

#Set working directory
WORKDIR /app

#copy package.json
COPY package.json .

#Install dependencies
RUN npm install

#Copy source code
COPY . .

#run the app
CMD ["npm", "start"]


