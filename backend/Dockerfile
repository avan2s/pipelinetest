FROM node:lts
WORKDIR /app
COPY package.json package-lock.json client.js /app/
RUN npm i
CMD ["node","client.js"]
