#/bin/bash

version=
downloadLatest(){

	mkdir -p backup

	mv *.jar backup

	echo Please enter artifactory username
	read ARTIFACTORY_USERNAME

	echo Please enter artifactory password
	read -s ARTIFACTORY_PASSWORD

	ARTIFACTORY_DOMAIN=https://artifactory.amelco.co.uk

	ARTIFACTORY_CREDENTIALS=${ARTIFACTORY_USERNAME}:${ARTIFACTORY_PASSWORD}

	version=`curl -s -u ${ARTIFACTORY_CREDENTIALS} "${ARTIFACTORY_DOMAIN}/artifactory/api/search/latestVersion?repos=ats-releases&g=server-tools&a=ats-betsync-msglog-tool"`
	wget --user ${ARTIFACTORY_USERNAME} --password ${ARTIFACTORY_PASSWORD} "${ARTIFACTORY_DOMAIN}/artifactory/ats-releases/server-tools/ats-betsync-msglog-tool/${version}/ats-betsync-msglog-tool-${version}.jar"	
}

formattedSports() {
	    echo $LISTOFSPORTS | tr -s '[:blank:]' '\n'
	}

lists(){	
	
	LISTOFSPORTS=$1
	sportsLength=$(echo "$LISTOFSPORTS" | wc -w)
	counter=0

	echo
	echo Sports Types:
	echo

	formattedSports | while read currentServer; do
	    serverName=$(echo $currentServer)
	    counter=$(($counter + 1))
	    echo "$counter: $currentServer"
	done

	echo
	echo -n "Please choose one of the elements : "

	read userAns

	if [[ -z $userAns || $userAns -lt 1 || $userAns -gt $sportsLength ]]; then
	    echo "User gave the answer $userAns which was not acceptable"
	    exit 1
	fi
}

#Check if jar exist and/or need the latest
CURRENT_JAR=$(ls |grep ats-betsync-msglog-tool-)
if [[ -z $CURRENT_JAR ]]; then	
      	downloadLatest
else	
  	echo "Detected <<" $CURRENT_JAR ">> Do you want to check for latest version?"
	select yn in "Yes" "No"; do
	    case $yn in
		Yes ) downloadLatest; break;;
		No ) break;;
	    esac
	done	
fi

#Display available feeds
lists 'LSPORTS'
chosenFeed=$(formattedSports | tail -n +$userAns | head -1)

#Display available sports
lists 'football tennis basketball american_football	'
chosenSport=$(formattedSports | tail -n +$userAns | head -1)

#Reaply by choosen feed and sport
#echo Please enter betsync username e.g. lsportsbetsyncin
#read BETSYNC_USER

#echo Please enter betsync password
#read -s BETSYNC_PW

function apply_dir () {
    local d="${1}"    
    echo -e "\nApplying file data/${chosenFeed}/${chosenSport}/$d"
    java -cp ${CURRENT_JAR} ats.betsync.in.replay.BetsyncInMessageReplayTool -delay 100 -username lsportsbetsyncin -password test1 -url http://localhost:8140/betsync-in/in -msg data/${chosenFeed}/${chosenSport}/$d
}

for d in $(ls -1 data/${chosenFeed}/${chosenSport}/ ); do
    if [[ $1 == "-q" ]]; then
	echo "APPLY ALL"
	apply_dir "$d"
    else
	    read -n1 -p "Replay $d [A]plly/[I]gnore/[S]Stop:" action
	    case $action in
		[aA] ) apply_dir "$d" ;;
		[iI] ) ;;
		[sS] ) exit 0;;
		* ) echo "Invalid option";       exit 1;;
	    esac
	    echo ""
		
    fi	
done
