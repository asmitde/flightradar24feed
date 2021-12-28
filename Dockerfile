# syntax=docker/dockerfile:1
FROM alpine:latest
COPY download_binary_armhf.sh .
RUN chmod +x download_binary_armhf.sh
RUN ./download_binary_armhf.sh
CMD ["./fr24feed_armhf/fr24feed"]