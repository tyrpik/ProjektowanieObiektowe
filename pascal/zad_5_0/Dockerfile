FROM debian:stable-slim

RUN apt-get update && apt-get install -y fpc && rm -rf /var/lib/apt/lists/*

WORKDIR /app
COPY zad_4_5.pas .
RUN fpc zad_4_5.pas
CMD ./zad_4_5 && /bin/bash