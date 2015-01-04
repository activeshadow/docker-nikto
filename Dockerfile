FROM debian:jessie

RUN apt-get update \
        && apt-get install -y libtimedate-perl libnet-ssleay-perl \
        && rm -rf /var/lib/apt/lists/*

ADD https://cirt.net/nikto/nikto-2.1.5.tar.gz /root/

WORKDIR /opt

RUN tar xzf /root/nikto-2.1.5.tar.gz \
        && rm /root/nikto-2.1.5.tar.gz \
        && sed -i 's/# EXECDIR/EXECDIR/' nikto-2.1.5/nikto.conf \
        && chmod +x nikto-2.1.5/nikto.pl \
        && ln -s /opt/nikto-2.1.5/nikto.pl /usr/local/bin/nikto \
        && ln -s /opt/nikto-2.1.5/nikto.conf /etc/nikto.conf \
        && nikto -update

WORKDIR /root

CMD ["nikto"]
