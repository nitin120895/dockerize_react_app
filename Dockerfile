# Step 1: Build the React app
FROM node:16-alpine AS build

# Set working directory
WORKDIR /app

# Install dependencies
COPY package.json package-lock.json ./
RUN npm install

# Copy the rest of the app and build
COPY . ./
RUN npm run build

# Install 'serve' globally
RUN npm install --global serve

# Expose the port the app will run on
EXPOSE 3000

# Start the application using 'serve'
CMD ["serve", "-s", "build", "-l", "3000"]
