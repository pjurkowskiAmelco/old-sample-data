 * Script will download latest ats-betsync-msglog-tool. If jar already exists will ask if latest version is needed and will override.
 * First will ask for feed type and then for sport type.
 * Once sport is selected will try to reply each event in sport selected folder.
 * In order to replay events we need third parties and trading running. e.g
	~/workspace/devenv/dev-server-env$ ./start-third-party.sh 
		starting consul
		starting artemis
		Starting artemis-service
		artemis-service is now running (10799)
		starting zookeeper
		Waiting 10 seconds for zookeeper to initialise...
		starting kafka
	~/workspace/devenv/dev-server-env$ ./start-trading.sh 
		starting ats-manager
		starting ats-betsync-proxy
		starting ats-betsync-in
		starting ats-market-server
		starting ats-betsync-out
		starting ats-trading-api
		starting ats-trading-graphql


 * New feeds and sports need to be added to 'lists' variable.
	lists 'LSPORTS'
	lists 'football tennis basketball american_football cricket'

 * Run script as: 
	./replay
	./replay -q Optional param to replay all events for selected sport. Will not ask for each event.


e.g.

	asanchez@asanchez:~/workspace/devenv/sample-data/replay$ ./replay.sh 
	mv: cannot stat '*.jar': No such file or directory
	Please enter artifactory username
	asanchez
	Please enter artifactory password
	--2020-07-29 10:12:15--  https://artifactory.amelco.co.uk/artifactory/ats-releases/server-tools/ats-betsync-msglog-tool/10/ats-betsync-msglog-tool-10.jar
	Resolving artifactory.amelco.co.uk (artifactory.amelco.co.uk)... 172.16.215.49
	Connecting to artifactory.amelco.co.uk (artifactory.amelco.co.uk)|172.16.215.49|:443... connected.
	HTTP request sent, awaiting response... 401 Unauthorized
	Authentication selected: Basic realm="Artifactory Realm"
	Reusing existing connection to artifactory.amelco.co.uk:443.
	HTTP request sent, awaiting response... 200 OK
	Length: 19758311 (19M) [application/java-archive]
	Saving to: ‘ats-betsync-msglog-tool-10.jar’

	ats-betsync-msglog-tool-10.jar                       100%[=====================================================================================================================>]  18.84M  2.83MB/s    in 8.2s    

	2020-07-29 10:12:24 (2.30 MB/s) - ‘ats-betsync-msglog-tool-10.jar’ saved [19758311/19758311]


	Sports Types:

	1: LSPORTS

	Please choose one of the elements : 1

	Sports Types:

	1: football
	2: tennis
	3: basketball
	4: american_football
	5: cricketqq

	Please choose one of the elements : 1
	Replay almería_vs_tenerife [A]plly/[I]gnore/[S]Stop:


 * Creates
ats_whitelabel=# select m.code,n.id,n.name,sys_ref,event_time from nodes n, market_areas m where n.maar_id = m.id and n.node_level = 4 and syst_id = 1;
       code        | id  |                            name                             | sys_ref |       event_time       
-------------------+-----+-------------------------------------------------------------+---------+------------------------
 SOCCER            | 227 | Seattle Sounders vs SJ Earthquakes                          | 5610085 | 2020-07-30 02:30:00+00
 SOCCER            | 225 | Orlando City vs Inter Miami CF                              | 5610087 | 2020-07-30 00:00:00+00
 SOCCER            | 223 | New York City FC vs Philadelphia Union                      | 5610086 | 2020-07-30 13:00:00+00
 SOCCER            | 221 | Nashville vs Chicago Fire                                   | 5610133 | 2020-07-30 02:30:00+00
 SOCCER            | 219 | Montreal Impact vs New England Revolution                   | 5610095 | 2020-07-30 00:00:00+00
 SOCCER            | 217 | Los Angeles FC vs Houston Dynamo                            | 5613348 | 2020-07-30 00:00:00+00
 SOCCER            | 215 | LA Galaxy vs Portland Timbers                               | 5613301 | 2020-07-30 02:30:00+00
 SOCCER            | 213 | FC Dallas vs Vancouver Whitecaps                            | 5610091 | 2020-07-30 02:30:00+00
 SOCCER            | 211 | FC Cincinnati vs Columbus Crew                              | 5610093 | 2020-07-30 02:30:00+00
 SOCCER            | 205 | England (Phantom) vs Netherlands (Cool_J)                   | 5618374 | 2020-07-30 15:50:00+00
 SOCCER            | 199 | Biashara United vs Ruvu Shooting                            | 5604129 | 2020-07-30 13:00:00+00
 TENNIS            | 275 | Eden Silva vs Kimberly Mpukusa                              | 5625110 | 2020-07-30 13:30:00+00
 TENNIS            | 273 | Diogo Marques vs Fabio Coelho                               | 5624630 | 2020-07-30 09:30:00+00
 TENNIS            | 267 | Boris Butulija vs Daniil Savelev                            | 5624809 | 2020-07-30 08:00:00+00
 TENNIS            | 261 | Alicia Barnett vs Freya Christie                            | 5625107 | 2020-07-30 15:00:00+00
 TENNIS            | 255 | Alex Bulte vs MA William                                    | 5622675 | 2020-07-30 05:20:00+00
 BASKETBALL        | 249 | Peoria All-Stars vs Herd That                               | 5620953 | 2020-07-30 18:00:00+00
 BASKETBALL        | 243 | Nes Ziona vs Hapoel Eilat                                   | 5587530 | 2020-07-30 17:05:00+00
 BASKETBALL        | 241 | Memphis Grizzlies (Ash) vs New Orleans Pelicans (Fosters23) | 5614721 | 2020-07-30 19:30:00+00
 BASKETBALL        | 239 | Maccabi Rishon Lezion vs Hapoel Jerusalem                   | 5591553 | 2020-07-30 18:15:00+00
 BASKETBALL        | 233 | Cleveland Cavaliers (Ash) vs Indiana Pacers (Zo0m)          | 5614734 | 2020-07-30 14:54:00+00
 AMERICAN_FOOTBALL | 289 | San Francisco 49ers vs Arizona Cardinals                    | 5401461 | 2020-09-13 20:25:00+00
 AMERICAN_FOOTBALL | 287 | New York Giants vs Pittsburgh Steelers                      | 5401480 | 2020-09-14 23:15:00+00
 AMERICAN_FOOTBALL | 285 | New Orleans Saints vs Tampa Bay Buccaneers                  | 5401437 | 2020-09-13 20:25:00+00
 AMERICAN_FOOTBALL | 283 | Detroit Lions vs Chicago Bears                              | 5401457 | 2020-09-13 17:00:00+00
 AMERICAN_FOOTBALL | 281 | Cincinnati Bengals vs Los Angeles Chargers                  | 5401439 | 2020-09-13 20:05:00+00
(26 rows)


 * https://confluence.amelco.co.uk/display/DEV/Replay+Tool+for+Betsync-In+Feeds


