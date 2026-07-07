FROM node:alpine3.22

WORKDIR /tmp

COPY index.js index.html package.json ./

EXPOSE 3000/tcp

RUN apk update && apk upgrade && \
    apk add --no-cache openssl curl gcompat iproute2 coreutils bash && \
    apk add --no-cache --virtual .build-deps cmake make g++ gcc python3 && \
    chmod +x index.js && \
    npm install && \
    apk del .build-deps

CMD ["node", "index.js"]
