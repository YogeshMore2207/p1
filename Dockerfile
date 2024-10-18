# Step 1: Build the React app
FROM node:18-alpine AS build

# Set the working directory inside the container
WORKDIR /app

# Copy the package.json and package-lock.json files
COPY package*.json ./

# Install dependencies
RUN npm install

# Copy the rest of the application files
COPY . .

# Build the React app for production
RUN npm run build

# Step 2: Serve the app with NGINX
FROM nginx:alpine

# Copy the build files from the previous stage to NGINX's web directory
COPY --from=build /app/build /usr/share/nginx/html

# Copy a custom NGINX configuration (optional)
# COPY nginx.conf /etc/nginx/nginx.conf

# Expose port 80 for the container
EXPOSE 80

# Start NGINX
CMD ["nginx", "-g", "daemon off;"]
