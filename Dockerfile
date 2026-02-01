FROM nginx:alpine

# Remove default nginx website
RUN rm -rf /usr/share/nginx/html/*

# Copy ALL static files
COPY src/ /usr/share/nginx/html/

# Expose HTTP
EXPOSE 80

CMD ["nginx", "-g", "daemon off;"]
