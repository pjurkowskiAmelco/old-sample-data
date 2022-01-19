#/bin/bash

#set -x

version=
downloadLatest(){

	mkdir -p backup

	mv ats-betsync-in-replay*.jar backup

	echo Please enter artifactory username
	read ARTIFACTORY_USERNAME

	echo Please enter artifactory password
	read -s ARTIFACTORY_PASSWORD

	ARTIFACTORY_DOMAIN=https://artifactory.amelco.co.uk

	ARTIFACTORY_CREDENTIALS=${ARTIFACTORY_USERNAME}:${ARTIFACTORY_PASSWORD}

	version=`curl -s -u ${ARTIFACTORY_CREDENTIALS} "${ARTIFACTORY_DOMAIN}/artifactory/api/search/latestVersion?repos=ats-releases&g=ats.server-tools&a=ats-pa-replay"`
	wget --user ${ARTIFACTORY_USERNAME} --password ${ARTIFACTORY_PASSWORD} "${ARTIFACTORY_DOMAIN}/artifactory/ats-releases/ats/server-tools/ats-pa-replay/${version}/ats-pa-replay-${version}.jar"	
}

# Check if jar exist and/or need the latest
CURRENT_JAR=$(ls |grep ats-pa-replay-)

if [[ -z $CURRENT_JAR ]]; then	
      	downloadLatest
fi

CURRENT_JAR=$(ls |grep ats-pa-replay-)

java -jar ${CURRENT_JAR} -url http://localhost:8620/ats-pa -msg $1

