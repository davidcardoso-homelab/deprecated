FROM debian:latest


RUN apt-get update && \
    apt-get install -y \
        git \
        autoconf \
        automake \
        libtool \
        pkg-config \
        libssl-dev \
        libpcap-dev \
        bind9utils \
        build-essential \
        curl \
        libnghttp2-dev \
        wget && \
    apt-get clean

# Clonar e compilar o dnsperf
WORKDIR /tmp

# Instala a biblioteca libck
RUN git clone https://github.com/concurrencykit/ck.git /ck && \
    cd /ck && \
    ./configure && \
    make && \
    make install

RUN wget https://www.dns-oarc.net/files/dnsperf/dnsperf-2.14.0.tar.gz && \
    tar zxvf dnsperf-2.14.0.tar.gz && \
    rm dnsperf-2.14.0.tar.gz && \
    cd dnsperf-2.14.0 && \
    ./configure && \
    make && \
    make install
    

ENTRYPOINT ["dnsperf"]
