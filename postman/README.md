# Local env testing project

This is postman collection and postman environment variables with defaults set for local env testing.

All Postman folders prefixed with WIP means it requires some extra work to run them.

Project mainly focuses on adding events, placing bets, resulting event.

By default variables are set for LSPORTS feed provider. To use Betradar please disable current variables:
```
ext_syst_code, ext_football_syst_ref, ext_syst_username
```
And use ones that were previously disabled.

To run full test You need to have:
* ats-manager
* ats-betsync-proxy
* ats-betsync-in
* ats-market-server
* ats-graphql
* ats-sportsbook
* ats-settler

Default user is test1 created by ./setupLocalEnvSportsbook.sh from dev-env-tool. Username is used only in Login request so to change it You need to go to this request.
