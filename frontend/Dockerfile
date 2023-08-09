FROM node:16.9.1-alpine as builder
# Create app directory
WORKDIR /usr/src/app
COPY . .
RUN npx browserslist@latest --update-db $$ npm install \
    && npm run build

FROM nginx:latest
COPY --from=builder /usr/src/app/dist /usr/share/nginx/html
EXPOSE 8080
# ENTRYPOINT ["http-server", "dist/frontend/", "-p", "80", "--proxy", "http://sausage-store-backend:8080"]