FROM ubuntu
RUN apt-get update && apt-get dist-upgrade -y
RUN apt install -y wget unzip
RUN apt install -y openjdk-8-jre-headless

RUN mkdir /usr/minecraft/
RUN mkdir /var/lib/minecraft/

WORKDIR /usr/minecraft/
COPY startup.sh ./startup.sh

WORKDIR /usr/minecraft/
COPY eula.txt ./eula.txt

WORKDIR /usr/minecraft/

CMD ./startup.sh $SERVER_FILES_URL