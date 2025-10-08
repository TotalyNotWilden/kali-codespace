# .gitpod.Dockerfile
FROM kalilinux/kali-rolling

ENV DEBIAN_FRONTEND=noninteractive

RUN apt-get update && \
    apt-get install -y --no-install-recommends \
      sudo \
      git \
      curl \
      wget \
      gnupg2 \
      lsb-release \
      apt-transport-https \
      ca-certificates \
      build-essential \
      python3 python3-pip python3-venv \
      nmap \
      nikto \
      sqlmap \
      hashcat \
      netcat-openbsd \
      unzip \
      jq \
      vim \
      tmux \
      locales && \
    apt-get clean && rm -rf /var/lib/apt/lists/*

# Set up locale (Gitpod sometimes needs this)
RUN locale-gen en_US.UTF-8
ENV LANG=en_US.UTF-8

# Create venv for Python
RUN python3 -m venv /home/gitpod/venv && \
    /home/gitpod/venv/bin/pip install --upgrade pip setuptools requests beautifulsoup4

ENV PATH="/home/gitpod/venv/bin:$PATH"

USER gitpod
WORKDIR /workspace
