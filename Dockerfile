FROM		phusion/baseimage
MAINTAINER	Ajeeth Samuel <ajeeth.samuel@gmail.com>

RUN apt-get update

# Seafile dependencies and system configuration
RUN curl -L -O https://launchpad.net/~frodo-vdr/+archive/ubuntu/testing-vdr/+files/libfreetype6_2.5.2-1ubuntu2.3_amd64.deb
RUN dpkg -i libfreetype6_2.5.2-1ubuntu2.3_amd64.deb
RUN apt-get install -y python2.7 python-setuptools python-simplejson python-imaging sqlite3 python-mysqldb python-memcache python-flup nginx ca-certificates mysql-client socat
RUN ulimit -n 30000


# Nginx configurations
RUN chown -R www-data:www-data /var/lib/nginx
RUN mkdir /etc/service/nginx
ADD service-nginx.sh /etc/service/nginx/run
RUN chmod 775 /etc/service/nginx/run
ADD seafile-nginx.conf /etc/nginx/sites-available/seafile
RUN rm /etc/nginx/sites-enabled/default
RUN ln -s /etc/nginx/sites-available/seafile /etc/nginx/sites-enabled/default
RUN rm /etc/nginx/sites-available/default

# Interface the environment
RUN mkdir /opt/seafile
VOLUME /opt/seafile
EXPOSE 443

# Baseimage init process
ENTRYPOINT ["/sbin/my_init"]

# Seafile daemons
RUN mkdir /etc/service/seafile /etc/service/seahub
ADD seafile.sh /etc/service/seafile/run
ADD seahub.sh /etc/service/seahub/run
RUN chmod 775 /etc/service/seafile/run
RUN chmod 775 /etc/service/seahub/run

ADD seafile-init /usr/local/sbin/seafile-init
RUN chmod 775 /usr/local/sbin/seafile-init

ADD seafileDB-init.sql /seafileDB-init.sql

# Clean up for smaller image
RUN apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*
