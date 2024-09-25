# Stage 1: Build the NestJS application
FROM node:18-alpine AS builder

# Set working directory inside the container
WORKDIR /usr/src/app

# Copy package files and install dependencies
COPY package*.json ./
RUN npm install

# Copy the rest of the app source code
COPY /. .

# Build the application
RUN npm run build

# Stage 2: Run the application
FROM node:18-alpine

# Set working directory inside the container
WORKDIR /usr/src/app

# Copy package files and install production dependencies
COPY package*.json ./
RUN npm install --omit=dev

# Copy the build output and Prisma schema from the build stage
COPY --from=builder /usr/src/app/dist ./dist

# Expose the application port
EXPOSE 80

# Start the application
CMD ["node", "dist/main.js"]
