run: 
	docker run \
		-d \
		--env DB_HOST="192.168.0.85" \
		--env DB_NAME="snorby" \
		--env DB_USER="snorbyuser" \
		--env DB_PASS="my_password" \
		--env SENSOR_NAME="Docker2" \
		-v /etc/suricata:/etc/suricata \
		-v /srv/var-log-suricata-test:/var/log/suricata \
		--name snorby-barnyard2 \
		iwa/docker-barnyard2 \
		/bin/bash

test: 
	docker run \
		-t -i\
		--env DB_HOST="192.168.0.85" \
		--env DB_NAME="snorby" \
		--env DB_USER="snorbyuser" \
		--env DB_PASS="my_password" \
		-v /etc/suricata:/etc/suricata \
		-v /srv/var-log-suricata-test:/var/log/suricata \
		--name snorby-barnyard2 \
		iwa/docker-barnyard2 \
		/bin/bash

config: build
	chcon -Rt svirt_sandbox_file_t /var/log/suricata
	chcon -Rt svirt_sandbox_file_t /etc/suricata

build:
	docker build -t iwa/docker-barnyard2 .

destroy:
	 docker rm snorby-barnyard2

