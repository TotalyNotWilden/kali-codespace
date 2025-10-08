# Use Kali rolling base image
FROM kalilinux/kali-rolling

# Avoid interactive prompts
ENV DEBIAN_FRONTEND=noninteractive

# Install basic tooling + Kali packages
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
      john \
      hydra \
      netcat-openbsd \
      unzip \
      jq \
      vim \
      tmux && \
    apt-get install -y metasploit-framework || true && \
    apt-get clean && rm -rf /var/lib/apt/lists/*

# Create a non-root user
ARG USERNAME=vscode
ARG USER_UID=1000
ARG USER_GID=$USER_UID

RUN groupadd --gid $USER_GID $USERNAME \
  && useradd --uid $USER_UID --gid $USER_GID -m $USERNAME \
  && echo "$USERNAME ALL=(ALL) NOPASSWD:ALL" > /etc/sudoers.d/$USERNAME \
  && chmod 0440 /etc/sudoers.d/$USERNAME

USER $USERNAME
WORKDIR /home/$USERNAME

# Create a Python virtual environment
RUN python3 -m venv /home/$USERNAME/venv

# Upgrade pip & install packages inside virtual environment
RUN /home/$USERNAME/venv/bin/pip install --upgrade pip setuptools \
    && /home/$USERNAME/venv/bin/pip install requests beautifulsoup4

# Ensure venv is used by default
ENV PATH="/home/$USERNAME/venv/bin:$PATH"
