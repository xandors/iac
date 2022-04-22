# iac

```
HOSTS=''

ansible-playbook --fork=24 \
  -i ./inventory/zandvoort/ \
  -u devops \
  --extra-vars="@./group_vars/zandvoort.yml" \
  --check --diff \
  --limit $HOSTS \
  deploy_splunk_cluster.yml

ansible-playbook --fork=24 \
  -i ./inventory/zandvoort/ \
  -u devops \
  --extra-vars="@./group_vars/zandvoort.yml" \
  --limit $HOSTS \
  deploy_splunk_cluster.yml
```

splunk@zandvoort-splunksearch-a-1:~/bin$ ./splunk add shcluster-member -new_member_uri https://10.30.20.163:8089
Failed to proxy call to member https://10.30.20.163:8089. ERROR:  You (user=admin2) do not have permission to perform this operation (requires capability: edit_search_head_clustering).

echo "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABgQDUCSAtSkwKNz1ROa1sMJgngvthDrK+GUqwO5EV6KQnwtWM+7YOrTOtfIruFtkX3mZJKC1fwp30Cn7KJvJrZsLZSe8Lt40XTvdCIWIrc2aTveMboSYaKo69Ds9PyjbPnTEzVHuQ5XG0Lt6VhX8uagnNBiDtcLErb9g1E96LhnjsQjwf0JueLYfsm95Y3bFOXuwfsFaJiY7nXjCbUnJrxUW7hZrPbXtbakkUbQa/JN/qyjFmA2tICuD9TnELKCRz3xPpKDBOAYEg1rh+cHPszhLLUb9U4rJRWUoCGeCEa9knebz3bcUe36MsBl3LZEFotMBa+iNzFTYwBjYltsO7D4jkweCFWuRL/TtVy9Q1efv6ac9tNR4BOUZ+ABOqVNgAf4BsRByQF4jwbxyaNweIvB7uTedyjsmZUIPH4zcnwOZhENDLiNWqhMm0iS2Dmxbh/yq53qrQn2BxXJQmgIHwSWBLrDK7EElc5OoszsveC1WkaDODkVPUv/RFAHWd3AY6f7M= alexandre.souza@fareharbor.com" >> ~/.ssh/authorized_keys

  /opt/splunk/bin/splunk add search-server https://10.30.20.233:8089 -auth admin:inWsKcvsaHKhkB -remoteUsername admin -remotePassword inWsKcvsaHKhkB
/opt/splunk/bin/splunk add search-server https://10.30.20.233:8089 -auth alexandre_souza:w2AI964xNlw4 -remoteUsername admin -remotePassword inWsKcvsaHKhkB
/opt/splunk/bin/splunk add search-server https://10.30.20.233:8089 -auth admin2:F@reharbor011819 -remoteUsername admin2 -remotePassword F@reharbor011819

/opt/splunk/bin/splunk bootstrap shcluster-captain -servers_list https://10.30.20.233:8089,https://10.30.20.57:8089,https://10.30.20.21:8089 -auth admin:inWsKcvsaHKhkB


/opt/splunk/bin/splunk apply shcluster-bundle -target https://10.30.20.163:8089 --answer-yes -auth admin:inWsKcvsaHKhkB
/opt/splunk/bin/splunk add search-server https://10.30.20.163:8089 -auth admin:inWsKcvsaHKhkB -remoteUsername admin -remotePassword inWsKcvsaHKhkB
/opt/splunk/bin/splunk add search-server https://10.30.20.163:8089 -auth admin2:F@reharbor011819 -remoteUsername admin -remotePassword inWsKcvsaHKhkB
/opt/splunk/bin/splunk bootstrap shcluster-captain -servers_list https://10.30.20.57:8089,https://10.30.20.21:8089 -auth admin:inWsKcvsaHKhkB
/opt/splunk/bin/splunk bootstrap shcluster-captain -servers_list https://10.30.20.57:8089,https://10.30.20.21:8089 -auth admin2:F@reharbor011819

/opt/splunk/bin/splunk bootstrap shcluster-captain -servers_list https://10.30.20.57:8089,https://10.30.20.21:8089,https://10.30.20.163:8089 -auth admin2:F@reharbor011819

servers = https://10.30.20.57:8089,https://10.30.20.21:8089,https://10.30.20.163:8089

curl -k -u alexandre_souza:w2AI964xNlw4 https://10.30.20.57:8089/services/authentication/users?output_type=json

	'./splunk show maintenance-mode'

	'./splunk show cluster-bundle-status'

	'./splunk show cluster-bundle-status --verbose'

	'./splunk show cluster-status'

	'./splunk show cluster-status --verbose'

	'./splunk show shcluster-maintenance-mode'

	'./splunk show shcluster-status'

	'./splunk show shcluster-status --verbose'

	'./splunk show kvstore-status'

	./splunk show guid


		'./splunk list health -features "BatchReader, TailReader"'

  	./splunk list cluster-config

  	'./splunk list master'

  	./splunk list excess-buckets

  	./splunk list excess-buckets main

  	./splunk list cluster-peers

  	./splunk list master-info

  	./splunk list cluster-generation

  	./splunk list cluster-buckets

  	./splunk list peer-info

  	./splunk list peer-buckets

  	'./splunk list shcluster-bundle -member_uri https://member_name:port

  	./splunk list shcluster-config

  	./splunk list shcluster-members

  	./splunk list shcluster-captain-info

  	./splunk list shcluster-artifacts

  	./splunk list shcluster-scheduler-jobs

  	./splunk list shcluster-member-info

  	./splunk list shcluster-configuration-set

  	./splunk list shcluster-member-artifacts

  	./splunk list inputstatus

  	./splunk list monitor

  	./splunk list indexer-discovery

  	./splunk list ad

  	./splunk list registry

  	./splunk list wmi

  	./splunk list eventlog

  	./splunk list monitornohandle

  	./splunk list winnetmon

  	./splunk list perfmon

  	./splunk list winhostmon

  	./splunk list winprintmon

  	./splunk list licenser-stacks

  	./splunk list licenses

  	./splunk list licenser-stacks

  	./splunk list licenser-pools

  	./splunk list licenser-slaves

  	./splunk list licenser-localslave

  	./splunk list licenser-groups

  	./splunk list licenser-messages


./splunk remove search-server -auth admin:inWsKcvsaHKhkB 10.30.20.180:8089
./splunk remove search-server -auth alexandre_souzax:w2AI964xNlw4 10.30.20.180:8089

Remove a peer from the manager node's list
After a peer goes down, it remains on the manager's list of peer nodes. The main effect is that it continues to appear on the manager node dashboard, although its status changes to "Down" or "GracefulShutdown", depending on how it went down.

You can use the splunk remove cluster-peers command to remove peers from the list:

./splunk remove cluster-peers -peers <guid>,<guid>,<guid>,...
Note the following:

All peers removed must be in the "Down" or "GracefulShutdown" state.
You specify the peers with a comma-separated list of GUIDs, one per peer.
The GUIDs can be specified with or without hyphens. For example: 4EB4D230-CB8B-4DEB-AD68-CF9209A6868A and 4EB4D230CB8B4DEBAD68CF9209A6868A are both valid.
If any GUID on the list is invalid, because one of the GUIDs does not correlate to a downed peer, the manager aborts the entire operation.
You can obtain peer GUIDs by running the command splunk list cluster-peers on the manager.
You can also remove the peer from the manager's list by restarting the manager.

For information on the manager node dashboard's list of peers, see View the manager node dashboard.


	'./splunk remove cluster-master https://127.0.0.1:8089 -secret testsecret'

	'./splunk remove cluster-master -master_uri https://127.0.0.1:8089 -secret testsecret'

	'./splunk remove excess-buckets'

	'./splunk remove excess-buckets main'

	'./splunk remove cluster-peers -peers GUID'

	'./splunk remove cluster-peers -peers GUID1,GUID2,GUID3'

	./splunk remove shcluster-member -mgmt_uri https://myserver:1234

	./splunk remove app unix

	./splunk remove indexer-discovery -name indexerDiscovery

	./splunk remove licenses BM+S8VetLnQEb1F+5Gwx9rR4MGGG5E3gQgV4Y91AkIE=

	./splunk remove licenses BM+S8VetLnQEb1F+5Gwx9rR4MGGG5E3gQgV4Y91AkIE=

	./splunk remove licenser-pools foo
