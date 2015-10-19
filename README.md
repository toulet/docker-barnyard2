# Docker Barnyard2
## About

A docker Barnyard2 image based on CentOS 7 docker image.

Cyrille TOULET <cyrille.toulet@linux.com>


## Configuration

Don't forget to configure shared folders (docker volumes):
```bash
chcon -Rt svirt_sandbox_file_t /var/log/suricata
chcon -Rt svirt_sandbox_file_t /etc/suricata
```

Environment variables to set:
 - **DB_HOST**: The MariaDB host
 - **DB_PORT**: The MariaDB port (defaults 3306)
 - **DB_NAME** The MariaDB database name
 - **DB_USER**: The MariaDB user
 - **DB_PASS**: The MariaDB password
 - **SENSOR_NAME**: The sensor name in database (defaults "Networking")


Don't forget to link the following volumes:
 - **/etc/suricata**: The suricata configuration file
 - **/var/log/suricata**: The unified2 log directory



## Execute

To launch docker instance, type:
```bash
docker run \
       --env DB_HOST="192.168.0.1 " \
       --env DB_NAME="snorby" \
       --env DB_USER="user" \
       --env DB_PASS="password" \
       --env SENSOR_NAME="SensorName" \
       -v /etc/suricata:/etc/suricata \
       -v /var/log/suricata:/var/log/suricata \
       -d \
       --name snorby-barnyard2 \
       toulet/docker-barnyard2 \
       /bin/bash
```



## Build image

If you need to build image, run:
```bash
docker build -t toulet/docker-barnyard2 .
```
