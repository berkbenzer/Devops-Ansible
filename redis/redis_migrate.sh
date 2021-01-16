
A$ redis-cli
127.0.0.1:6379> CONFIG GET dir
1) "dir"
2) "/var/lib/redis/"
127.0.0.1:6379> SAVE
OK

A$ scp /var/lib/redis/dump.rdb myuser@B:/tmp/dump.rdb


B$ sudo service redis-server stop
B$ sudo cp /tmp/dump.rdb /var/lib/redis/dump.rdb
B$ sudo chown redis: /var/lib/redis/dump.rdb
B$ sudo service redis-server start
