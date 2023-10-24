FROM node:20-alpine

WORKDIR /app

COPY package.json ./

RUN npm i nextjs -g
RUN npm install

COPY . .

RUN npm run build

CMD ["npm", "run", "start"]
