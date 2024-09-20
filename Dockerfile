# Use the official Node.js image as base
FROM node:18

# Set the working directory inside the container
WORKDIR /usr/src/app

# Copy package.json and package-lock.json to the working directory
COPY package*.json ./

# Install dependencies
RUN npm install

# Install Chrome pre-requisites
RUN apt-get update && apt-get install -y wget gnupg

# Add Google's official GPG key
RUN wget -q -O - https://dl.google.com/linux/linux_signing_key.pub | apt-key add -

# Add the Google Chrome repository
RUN sh -c 'echo "deb [arch=amd64] http://dl.google.com/linux/chrome/deb/ stable main" >> /etc/apt/sources.list.d/google-chrome.list'

# Update package list and install Chrome
RUN apt-get update && apt-get install -y google-chrome-stable

# Copy the rest of the application code
COPY . .

# Expose the port your app runs on
EXPOSE 8080

# Command to run your application
CMD ["npm", "run", "start"]
