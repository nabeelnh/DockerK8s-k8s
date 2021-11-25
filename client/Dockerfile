# Base Image
FROM node:16-alpine AS builder

# Set working directory
WORKDIR '/app'

# Dependencies
COPY ./package.json ./
RUN npm install
COPY ./ ./

# Running command
RUN npm run build

# ------------------------------------------------------------------------------
# ------------------------------------------------------------------------------
# ------------------------------------------------------------------------------

# New Image
FROM nginx:latest

# Expose port
EXPOSE 3000

# Copy from previous image
COPY ./nginx/default.conf /etc/nginx/conf.d/default.conf
COPY --from=builder /app/build /usr/share/nginx/html