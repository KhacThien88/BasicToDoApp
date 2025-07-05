FROM node:24-alpine3.21 AS builder

WORKDIR /app

COPY package*.json ./

RUN npm install --production

COPY . .

FROM node:24-alpine3.21

WORKDIR /app

COPY --from=builder /app/node_modules ./node_modules
COPY --from=builder /app/server.js ./

RUN npm cache clean --force

EXPOSE 5000

CMD ["node", "server.js"]