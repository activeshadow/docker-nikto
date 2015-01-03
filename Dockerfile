FROM debian:jessie

RUN apt-get update \
        && apt-get install -y libtimedate-perl libnet-ssleay-perl \
        && rm -rf /var/lib/apt/lists/*

ADD https://cirt.net/nikto/nikto-2.1.5.tar.gz /root/

WORKDIR /opt

RUN tar xzf /root/nikto-2.1.5.tar.gz \
        && rm /root/nikto-2.1.5.tar.gz \
        && mv nikto-2.1.5 nikto \
        && chmod +x nikto/nikto.pl \
        && ln -s /opt/nikto/nikto.pl /usr/local/bin/nikto \
        && cp nikto/nikto.conf /etc/ \
        && nikto -update

WORKDIR /root

CMD ["nikto"]
