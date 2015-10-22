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
```



## Build image

If you need to build image, run:
```bash
docker build -t toulet/docker-barnyard2 .
```



## Example

Assuming Suricata is installed and configured on your system
we will launch an instance of MariaDB, and Snorby of Barnyard2.


```bash
MY_IP="192.168.0.1"
PASSWORD=$(openssl rand -base64 12)

echo "The database password for user 'ids' is '$PASSWORD'"

docker run \
       --env="MARIADB_USER=ids" \
       --env="MARIADB_PASS=$PASSWORD" \
       -d  \
       -p 3306:3306 \
       --name ids-mariadb \
       million12/mariadb

docker run \
       --env="DB_ADDRESS=$MY_IP" \
       --env="DB_USER=ids" \
       --env="DB_PASS=$PASSWORD" \
       -d \
       --name ids-snorby \
       polinux/snorby

docker run \
       --env DB_HOST="$MY_IP" \
       --env DB_NAME="snorby" \
       --env DB_USER="ids" \
       --env DB_PASS="$PASSWORD" \
       --env SENSOR_NAME="IDS" \
       -v /etc/suricata:/etc/suricata \
       -v /var/log/suricata:/var/log/suricata \
       -d \
       --name ids-barnyard2 \
       toulet/docker-barnyard2
```

Now, visit your server website ;~)
