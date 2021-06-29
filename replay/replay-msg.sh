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

	version=`curl -s -u ${ARTIFACTORY_CREDENTIALS} "${ARTIFACTORY_DOMAIN}/artifactory/api/search/latestVersion?repos=ats-releases&g=ats.server-tools&a=ats-betsync-in-replay"`
	wget --user ${ARTIFACTORY_USERNAME} --password ${ARTIFACTORY_PASSWORD} "${ARTIFACTORY_DOMAIN}/artifactory/ats-releases/ats/server-tools/ats-betsync-in-replay/${version}/ats-betsync-in-replay-${version}.jar"	
}

# Check if jar exist and/or need the latest
CURRENT_JAR=$(ls |grep ats-betsync-in-replay-)

if [[ -z $CURRENT_JAR ]]; then	
      	downloadLatest
fi

CURRENT_JAR=$(ls |grep ats-betsync-in-replay-)

BSIN_USER=${BETSYNC_IN_USER:-AmelcoAdmin}
BSIN_PWD=${BETSYNC_IN_PWD:-test1}

java -cp ${CURRENT_JAR} ats.betsync.in.replay.BetsyncInMessageReplayTool -username ${BSIN_USER} -password ${BSIN_PWD} -url http://localhost:8120/betsync-proxy/in/ -msg $1

