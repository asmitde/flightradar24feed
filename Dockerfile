FROM alpine:latest

WORKDIR /app
COPY download_binary_armhf.sh .
RUN chmod +x download_binary_armhf.sh
RUN ./download_binary_armhf.sh

ENTRYPOINT [ "/app/fr24feed_armhf/fr24feed", "--config-file", "/app/config/fr24feed.ini" ]