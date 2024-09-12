FROM node:22.5.1

WORKDIR /app


COPY package*.json ./
RUN npm install

COPY . .

EXPOSE 3001
ENV PORT=3001

CMD ["npm", "start"]

adadada