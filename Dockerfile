FROM node:21-alpine

WORKDIR /app

ENV NEXT_TELEMETRY_DISABLED 1

COPY package*.json ./
RUN npm ci

COPY svelte.config.js postcss.config.js tailwind.config.js vite.config.js ./
COPY static ./static
COPY src ./src

RUN npm run build

EXPOSE 3000

CMD node build
