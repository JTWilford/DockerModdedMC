#!/bin/bash
# Check if the server files exist
FILE=/var/lib/minecraft/serverprepared.txt
DOCKER_CONFIG=/run/secrets/server.properties
if [ -f "$FILE" ]; then
    echo "Server prepared!"
else 
    echo "Server has not been prepared..."
	if [ -z "$SERVER_FILES_URL" ]; then
		echo "Server Files URL not set!!! Setting to argument"
		SERVER_FILES_URL=$1
	fi
	# Download the modpack files
	wget ${SERVER_FILES_URL} -O temp.zip
	unzip -d ./server temp.zip
	rm temp.zip
	cp ./eula.txt ./server/eula.txt
	

	cp -a ./server/. /var/lib/minecraft/
	rm -r ./server
	
	chmod -R 771 /var/lib/minecraft
	cd /var/lib/minecraft/
	./Install.sh && echo yes >> /var/lib/minecraft/serverprepared.txt
	
	if [ -f "$DOCKER_CONFIG" ]; then
		echo "Found docker secret containing server.properties!!!"
		cp /run/secrets/server.properties /var/lib/minecraft/server.properties
	fi
	
	chmod -R 771 /var/lib/minecraft
fi

env
# Start the server
cd /var/lib/minecraft/
./ServerStart.sh