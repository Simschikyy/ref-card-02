# ---------- Stage 1: Build ----------
# Node installiert die Dependencies und baut die statischen Dateien.
FROM node:22-alpine AS build
WORKDIR /app

# Zuerst nur package.json / package-lock.json kopieren: Die Dependencies
# landen in einem eigenen Layer und werden nur bei Änderungen neu installiert.
COPY package.json package-lock.json ./
RUN npm ci

COPY public ./public
COPY src ./src
RUN npm run build

# ---------- Stage 2: Runtime ----------
# Die fertige React-App besteht nur aus statischen Dateien.
# Dafür reicht ein nginx-Webserver, Node wird nicht mehr gebraucht.
FROM nginx:alpine
COPY --from=build /app/build /usr/share/nginx/html

# nginx hört auf Port 80.
EXPOSE 80
CMD ["nginx", "-g", "daemon off;"]
