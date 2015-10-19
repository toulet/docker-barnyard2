FROM centos:centos7
MAINTAINER Cyrille TOULET <cyrille.toulet@linux.com>

ENV SENSOR_NAME="Networking"
ENV DB_HOST="localhost"
ENV DB_PORT="3306"
ENV DB_NAME="snorby"
ENV DB_USER="snorby"
ENV DB_PASS="secret"

VOLUME ["/var/log/suricata"]
VOLUME ["/etc/suricata"]

COPY etc /etc/
COPY entrypoint.sh /

RUN \
    yum -y update && \
    yum -y install epel-release && \
    yum -y groupinstall "Development Tools" && \
    yum -y install mysql mysql-devel git libtool libpcap-devel daq-2.0.6-1 \
    	libgcc-4.8.2-16.2.el7_0.x86_64 gcc-4.8.2-16.2.el7_0.x86_64 flex-2.5.37-3.el7.x86_64 \
	bison-2.7-4.el7.x86_64 zlib-1.2.7-13.el7.x86_64 zlib-devel-1.2.7-13.el7.x86_64 \
	libpcap-1.5.3-4.el7_1.2.x86_64 libpcap-devel-1.5.3-4.el7_1.2.x86_64 \
	tcpdump-4.5.1-2.el7.x86_64 libdnet-devel-1.12-13.1.el7.x86_64 gcc libpcap-devel \
    	jansson-devel nss-devel libcap-ng-devel libnet-devel pcre-devel libyaml-devel \
	file-devel zlib-devel kernel-headers.x86_64 kernel-devel.x86_64 && \
    yum -y install https://www.snort.org/downloads/snort/daq-2.0.6-1.centos7.x86_64.rpm && \
    cd /usr/local/src/ && \
    git clone https://github.com/firnsy/barnyard2.git barnyard2 && \
    cd barnyard2 && \
    ./autogen.sh && \
    ./configure --with-mysql --with-mysql-libraries=/usr/lib64/mysql && \
    make && \
    make install && \
    mkdir /var/log/barnyard2

ENTRYPOINT ["/entrypoint.sh"]
