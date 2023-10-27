FROM node:21-alpine

WORKDIR /app

ENV NEXT_TELEMETRY_DISABLED 1

COPY package*.json ./
RUN npm ci

COPY next.config.js postcss.config.js tailwind.config.ts tsconfig.json ./
COPY public ./public
COPY app ./app

RUN npm run build

EXPOSE 3000
CMD npm run start
