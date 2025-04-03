FROM manjarolinux/base:latest

ARG BUILDERNAME=builder
ARG USERNAME=manjaro

RUN pacman-mirrors -c Japan,United_States\
    && pacman -Sy\
    && pacman -Syu --noconfirm --needed git sudo wget nano go base-devel
RUN usermod -l ${USERNAME} ${BUILDERNAME}\
    && groupmod -n ${USERNAME}  ${BUILDERNAME}\
    && usermod -d /home/${USERNAME}  -m ${USERNAME} 
RUN usermod -aG wheel ${USERNAME}\
    && passwd -d ${USERNAME}\
    && printf "%%wheel ALL=(ALL) NOPASSWD:ALL\n" | tee -a /etc/sudoers.d/wheel\
    && printf "[user]\ndefault=${USERNAME}\n" | tee /etc/wsl.conf

RUN echo "en_US.UTF-8 UTF-8" > /etc/locale.gen \
    && locale-gen
ENV LANG="en_US.UTF-8" \
    LANGUAGE="en_US:en" \
    LC_ALL="en_US.UTF-8"

USER ${USERNAME}

WORKDIR /home/${USERNAME}