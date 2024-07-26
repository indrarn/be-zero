FROM node:22.5.1

WORKDIR /app

COPY package.json .

RUN npm install

COPY . .

EXPOSE 3000

ENV ADDRESS=0.0.0.0 PORT=3000

CMD ["npm", "run", "start"]

