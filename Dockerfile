FROM node:16

WORKDIR /app

# Copy dependencies
COPY package*.json ./

# Install dependencies
RUN npm install

# Copy project files
COPY . .

# Expose default port (container runs on 3000)
EXPOSE 3000

# Start application
CMD ["npm", "start"]
