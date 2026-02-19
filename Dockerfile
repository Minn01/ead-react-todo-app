# syntax=docker/dockerfile:1
# FROM node:20-alpine
# WORKDIR /usr/src/app
# RUN npm install --omit=dev
# RUN apk add --no-cache python3 g++ make
# COPY . .
# WORKDIR /app
# COPY . .
# RUN yarn install --production
# CMD ["node", "src/index.js"]
# EXPOSE 3000

FROM node:18-alpine

WORKDIR /usr/src/app

# Install build tools for sqlite3
RUN apk add --no-cache python3 make g++

# Copy dependency files
COPY package*.json ./

# Install dependencies
RUN npm install --omit=dev

# Copy source
COPY . .

# Expose port
EXPOSE 3000

# Start app
CMD ["node", "src/index.js"]