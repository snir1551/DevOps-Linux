FROM node:18-alpine

WORKDIR /app

COPY package*.json ./

RUN apk add --no-cache curl && rm -rf /var/cache/apk/*

RUN npm install

COPY . .

EXPOSE 3000

HEALTHCHECK --interval=30s --timeout=5s --start-period=5s --retries=3 CMD curl -f http://localhost:3000/ || exit 1

CMD ["npm", "start"]