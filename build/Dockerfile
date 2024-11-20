# Stage 1: Build stage
FROM ubuntu:noble AS builder

LABEL maintainer="Rod Anami <rod.anami@kyndryl.com>"

RUN apt-get update && \
    apt-get install --no-install-recommends -y \
        curl \
        tar \
        wget

# Configure curl to use system certificates
RUN mkdir -p /etc/ssl/certs && echo <<EOF > .curlrc
capath=/etc/ssl/certs/
cacert=/etc/ssl/certs/ca-certificates.crt
EOF
# Download and install CA certificates
RUN wget --no-check-certificate https://curl.se/ca/cacert.pem && cp ./cacert.pem /etc/ssl/certs/ca-certificates.crt

# Install Docker CLI
RUN curl -fsSL https://download.docker.com/linux/static/stable/x86_64/docker-27.3.1.tgz | tar xvz

# Install kubectl
RUN curl -LO "https://dl.k8s.io/release/$(curl -L -s https://dl.k8s.io/release/stable.txt)/bin/linux/amd64/kubectl"

# Install k9s
RUN curl -L0 https://github.com/derailed/k9s/releases/download/v0.32.7/k9s_Linux_amd64.tar.gz | tar xvz

# Stage 2: Final stage
FROM ubuntu:noble

LABEL maintainer="Rod Anami <rod.anami@kyndryl.com>"

RUN sed -i 's:^path-exclude=/usr/share/man:#path-exclude=/usr/share/man:' /etc/dpkg/dpkg.cfg.d/excludes
# Update package repositories
RUN apt-get update
ENV DEBIAN_FRONTEND="noninteractive"
# Install ninja SRE tools
RUN apt-get install --no-install-recommends -y \
        arping \
        arptables \
        bash \
        bridge-utils \
        ca-certificates \
        curl \
        conntrack \
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
        netcat-traditional \
        openssl \
        openssh-client \
        podman \
        tar \
        tcpdump \
        traceroute \
        tree \
        ngrep \
        vim \
        wget
# Configure tcpdump, traceroute, and curl
RUN rm -rf /var/lib/apt/lists/* && \
    mv /usr/sbin/traceroute /usr/bin/traceroute &&\
    mkdir -p /etc/ssl/certs

# Copy binaries from builder stage
COPY --from=builder /docker/docker /usr/bin/docker
COPY --from=builder /kubectl /usr/bin/kubectl
COPY --from=builder /k9s /usr/bin/k9s
COPY --from=builder /etc/ssl/certs/ca-certificates.crt /etc/ssl/certs/ca-certificates.crt

# Create .kube directory
RUN mkdir -p /root/.kube

WORKDIR /root
CMD ["bash"]