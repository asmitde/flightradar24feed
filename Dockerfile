FROM debian:bullseye-slim

WORKDIR /app

COPY download_binary_armhf.sh .

RUN apt-get update && apt-get upgrade -y && apt-get install wget -y

RUN ./download_binary_armhf.sh

RUN mkdir config

COPY fr24feed.ini /etc/fr24feed.ini

EXPOSE 8754

ENTRYPOINT [ "/app/fr24feed_armhf/fr24feed" ]

CMD [ "--config-file=/app/config/fr24feed.ini" ]
