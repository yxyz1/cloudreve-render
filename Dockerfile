FROM alpine:edge

ADD conf.ini /root/cloudreve/conf.ini
ADD run.sh /root/cloudreve/run.sh
ADD aria2.conf /root/aria2/aria2.conf
ADD trackers-list-aria2.sh /root/aria2/trackers-list-aria2.sh

RUN apk update \
    && apk add wget curl jq findutils ca-certificates bash \
    && curl -fsSL git.io/aria2c.sh | bash

RUN wget -qO cloudreve.tar.gz https://github.com/cloudreve/Cloudreve/releases/download/3.6.2/cloudreve_3.6.2_linux_amd64.tar.gz \
    && wget -qO /root/aria2/dht.dat https://github.com/P3TERX/aria2.conf/raw/master/dht.dat \
    && wget -qO /root/aria2/dht6.dat https://github.com/P3TERX/aria2.conf/raw/master/dht6.dat
    
RUN tar -zxvf cloudreve.tar.gz -C /root/cloudreve

RUN touch /root/aria2/aria2.session /root/aria2/aria2.log
RUN chmod +x /root/cloudreve/alist \
    && chmod +x /root/aria2/trackers-list-aria2.sh \
    && chmod +x /root/cloudreve/run.sh
RUN mkdir -p /root/Download

CMD /root/cloudreve/run.sh

EXPOSE 8080
