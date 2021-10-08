# MongoDB Replica Set

A Replica Set of MongoDB (v.4.4.9) running in a Ubuntu-based Docker container

## Not For Production

The key motivation for this image is to have a __ready-made__ replica set of MongoDB running inside docker container for __CI tests__.

To run the container, execute the following command:
```shell
docker run --name mongo-replica-set -d -p 27011:27011 -p 27012:27012 -p 27013:27013 northwestwitch/mongo4.4-replica-set
```

Wait for 30 to 35 seconds in order to properly start all database instances and replica-set initialization.

Once ready, the replica-set can be accessed using the following connection string:
```shell
mongodb://localhost:27011,localhost:27012,localhost:27013/?replicaSet=rs0&readPreference=primary&ssl=false
```
