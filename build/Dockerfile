# Stage 1: Build stage
FROM ubuntu:noble AS builder

LABEL maintainer="Rod Anami <rod.anami@kyndryl.com>"

RUN apt-get update && \
    apt-get install --no-install-recommends -y \
        ca-certificates \
        curl \
        tar

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
        vim && \
    rm -rf /var/lib/apt/lists/*

# Clean up
RUN apt-get autoremove && apt-get clean

# Configure tcpdump and traceroute
RUN mv /usr/sbin/traceroute /usr/bin/traceroute

# Copy binaries from builder stage
COPY --from=builder /docker/docker /usr/bin/docker
COPY --from=builder /kubectl /usr/bin/kubectl
COPY --from=builder /k9s /usr/bin/k9s

# Create .kube directory
RUN mkdir -p /root/.kube

WORKDIR /root
CMD ["bash"]