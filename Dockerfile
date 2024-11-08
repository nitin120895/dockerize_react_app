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

# Step 2: Serve with NGINX
FROM nginx:alpine

# Copy the build files from the build stage
COPY --from=build /app/build /usr/share/nginx/html

# Expose port 80 for NGINX
EXPOSE 80

# Start NGINX server
CMD ["nginx", "-g", "daemon off;"]
