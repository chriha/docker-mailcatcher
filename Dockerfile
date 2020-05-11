FROM ubuntu:19.04

MAINTAINER "Christopher Hartmann"

RUN apt-get update && apt-get install -y locales \
    && locale-gen en_US.UTF-8

ENV LANG en_US.UTF-8
ENV LANGUAGE en_US:en
ENV LC_ALL en_US.UTF-8

RUN apt-get update \
    && apt-get install -y software-properties-common build-essential sqlite3 libsqlite3-dev supervisor ruby ruby-dev rubygems vim htop \
    && apt-get remove -y --purge software-properties-common \
    && apt-get -y autoremove \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

RUN gem install mailcatcher -v 0.7.1 --no-ri --no-rdoc

COPY conf/supervisord.conf /etc/supervisor/conf.d/supervisord.conf

EXPOSE 1025 1080

CMD ["/usr/bin/supervisord"]
