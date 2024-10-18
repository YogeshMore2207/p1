# Use an official Node.js runtime as a base image
FROM node:16.20.0-alpine

# Set environment to production (or adjust based on your environment)
ENV NODE_ENV=production

# Set the working directory inside the container
WORKDIR /code

# Copy the package.json and package-lock.json to the container
COPY package.json package-lock.json ./

# Install only production dependencies
RUN npm install --only=production

# Copy the rest of the app source code
COPY . .

# Build the React application
RUN npm run build

# Expose port 5000 (if using a tool like serve or Express to serve static files)
EXPOSE 5000

# Install a simple HTTP server to serve static files
RUN npm install -g serve

# Use "serve" to serve the build directory on port 5000
CMD ["serve", "-s", "build", "-l", "5000"]
