#!/bin/sh

cp /etc/barnyard2/barnyard2.conf.skel /etc/barnyard2/barnyard2.conf
sed -i "s/{SENSOR_NAME}/$SENSOR_NAME/g" /etc/barnyard2/barnyard2.conf
sed -i "s/{DB_HOST}/$DB_HOST/g" /etc/barnyard2/barnyard2.conf
sed -i "s/{DB_PORT}/$DB_PORT/g" /etc/barnyard2/barnyard2.conf
sed -i "s/{DB_NAME}/$DB_NAME/g" /etc/barnyard2/barnyard2.conf
sed -i "s/{DB_USER}/$DB_USER/g" /etc/barnyard2/barnyard2.conf
sed -i "s/{DB_PASS}/$DB_PASS/g" /etc/barnyard2/barnyard2.conf
echo "Barnyard2 configuration file updated!"

echo "Starting barnyard2..."
/usr/local/bin/barnyard2 -c /etc/barnyard2/barnyard2.conf -d /var/log/suricata -f unified2.alert
