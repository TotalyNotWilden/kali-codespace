# == Codespaces-friendly Kali (minimal) ==
# Use Kali rolling base image (keeps Kali environment but minimal)
FROM kalilinux/kali-rolling

ENV DEBIAN_FRONTEND=noninteractive

# --- Minimal apt install: keep image small and reliable in Codespaces ---
# We keep only essentials and a few lightweight pentest tools like nmap & sqlmap.
# Heavy tools (metasploit, hashcat, john, hydra, etc.) are intentionally omitted
# and can be installed later in a running container.
RUN apt-get update && \
    apt-get install -y --no-install-recommends \
      ca-certificates \
      gnupg2 \
      apt-transport-https \
      lsb-release \
      wget \
      curl \
      git \
      sudo \
      python3 \
      python3-venv \
      python3-pip \
      vim \
      tmux \
      unzip \
      jq \
      netcat-openbsd \
      nmap \
      sqlmap && \
    apt-get clean && rm -rf /var/lib/apt/lists/*

# --- Create non-root user (Codespaces likes 'vscode') ---
ARG USERNAME=vscode
ARG USER_UID=1000
ARG USER_GID=$USER_UID

RUN groupadd --gid $USER_GID $USERNAME || true \
  && useradd --uid $USER_UID --gid $USER_GID -m $USERNAME || true \
  && echo "$USERNAME ALL=(ALL) NOPASSWD:ALL" > /etc/sudoers.d/$USERNAME \
  && chmod 0440 /etc/sudoers.d/$USERNAME

USER $USERNAME
WORKDIR /home/$USERNAME

# --- Python virtual environment to avoid PEP 668 "externally-managed" issues ---
RUN python3 -m venv /home/$USERNAME/venv \
    && /home/$USERNAME/venv/bin/pip install --upgrade pip setuptools \
    && /home/$USERNAME/venv/bin/pip install requests beautifulsoup4

# Make venv first in PATH for terminals and processes
ENV PATH="/home/$USERNAME/venv/bin:${PATH}"

# Convenience: auto-activate venv in interactive shells
RUN echo 'if [ -f "/home/'"$USERNAME"'/venv/bin/activate" ]; then source /home/'"$USERNAME"'/venv/bin/activate; fi' \
    >> /home/$USERNAME/.bashrc

# Keep image lean: optionally remove apt caches (done above), leave a note
LABEL maintainer="you@example.com"
