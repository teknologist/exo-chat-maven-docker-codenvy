FROM teknologist/exo-maven
MAINTAINER Eric Taieb Walch <teknologist@gmail.com>

ENV M2_HOME /opt/apache-maven-3.2.3

USER root
RUN chown -R ${EXO_USER}:${EXO_GROUP} ${EXO_APP_DIR}/

RUN apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv 7F0CEB10
RUN echo 'deb http://downloads-distro.mongodb.org/repo/ubuntu-upstart dist 10gen' | sudo tee /etc/apt/sources.list.d/mongodb.list
RUN apt-get -qq update && \
  apt-get -qq -y install mongodb-org

USER exo

RUN mv ${EXO_APP_DIR}/current/start_eXo.sh ${EXO_APP_DIR}/current/start_eXo-ORI.sh
ADD local.json ${EXO_APP_DIR}/current/addons/
ADD start_eXo.sh ${EXO_APP_DIR}/current/start_eXo.sh
