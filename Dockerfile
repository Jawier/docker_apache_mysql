# See https://github.com/phusion/baseimage-docker/blob/master/Changelog.md for
# a list of version numbers.
FROM phusion/baseimage:0.9.11
MAINTAINER jawier jawierandrade@gmail.com

# Set correct environment variables.
ENV HOME /root

# Regenerate SSH host keys. 
RUN /etc/my_init.d/00_regen_ssh_host_keys.sh

# Use baseimage-docker's init system..
CMD ["/sbin/my_init"]

RUN apt-get update
RUN apt-get upgrade -y
RUN apt-get install -y wget
RUN apt-get install -y ca-certificates
RUN apt-get install -y python
RUN apt-get install -y unzip
RUN apt-get install -y mysql-server
RUN apt-get install -y php5-mysql
RUN apt-get install -y apache2
RUN apt-get install -y php5

#APACHE
RUN mkdir /etc/service/apache2
COPY apache2/run.sh /etc/service/apache2/run
RUN chmod +x /etc/service/apache2/run

#MySQL
RUN mkdir /etc/service/MySQL
COPY MySQL/run.sh /etc/service/MySQL/run
RUN chmod +x /etc/service/MySQL/run

# Clean up APT when done.
RUN apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

# OJO ATENCION QUITAR EN PRODUCCION 
# Enabling the insecure key permanently
RUN /usr/sbin/enable_insecure_key