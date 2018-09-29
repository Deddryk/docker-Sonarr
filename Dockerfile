FROM mono:latest
MAINTAINER deddryk

WORKDIR /tmp/docker-build

RUN groupadd -g 997 sonarr &&\
    groupadd -g 998 shared_data &&\
    useradd -r -u 997 -g sonarr -d /sonarr -m sonarr && \
    usermod -a -G shared_data sonarr
RUN apt-key adv --keyserver keyserver.ubuntu.com --recv-keys 0xFDA5DFFC
RUN echo "deb http://apt.sonarr.tv/ master main" > /etc/apt/sources.list.d/sonarr.list
RUN apt-get update
RUN apt-get install -y nzbdrone
RUN chown -R sonarr:sonarr /opt/NzbDrone

RUN rm -rf /tmp/docker-build

USER sonarr

VOLUME /downloads /sonarr /TV

EXPOSE 8989

CMD ["mono", "/opt/NzbDrone/NzbDrone.exe"]

