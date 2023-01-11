FROM ubuntu:jammy-20221130

LABEL maintainer="Rod Anami <rod.anami@kyndryl.com>"

RUN sed -i 's:^path-exclude=/usr/share/man:#path-exclude=/usr/share/man:' /etc/dpkg/dpkg.cfg.d/excludes
# Update package repositories
RUN apt-get update
ENV DEBIAN_FRONTEND="noninteractive"
# Install ninja SRE tools
RUN apt-get install --no-install-recommends -y \
        arping \
        arptables \
        bridge-utils \
        ca-certificates \
        conntrack \
        curl \
        dnsutils \
        ethtool \
        iperf \
        iperf3 \
        iproute2 \
        ipset \
        iptables \
        iputils-ping \
        jq \
        kmod \
        ldap-utils \
        less \
        libpcap-dev \
        man \
        manpages-posix \
        netcat \
        openssl \
        openssh-client \
        tcpdump \
        traceroute \
        tree \
        ngrep \
        vim \
        wget
# Configure tcpdump and traceroute
RUN rm -rf /var/lib/apt/lists/* && \
    mv /usr/sbin/traceroute /usr/bin/traceroute
# Install Docker CLI
RUN curl -sLf https://download.docker.com/linux/ubuntu/dists/jammy/stable/binary-amd64/Release > /usr/bin/docker && \
    chmod +x /usr/bin/docker
# Install kubectl
RUN curl -LO "https://dl.k8s.io/release/$(curl -L -s https://dl.k8s.io/release/stable.txt)/bin/linux/amd64/kubectl" &&\
    mkdir -p /root/.kube
# Install k9s
RUN curl -L0 https://github.com/derailed/k9s/releases/download/v0.26.7/k9s_Linux_x86_64.tar.gz | tar xvz && \
    mv k9s /usr/bin && rm README.md LICENSE
WORKDIR /root
CMD ["sh"]