FROM ubuntu:20.04
ENV DEBIAN_FRONTEND=noninteractive
WORKDIR /tmp
COPY install_super.bash ./
RUN ./install_super.bash -n

# Add and switch user
ARG USER
ARG UID
ARG GID
RUN groupadd -g $GID $USER
RUN useradd -m -u $UID -g $GID -G sudo $USER
USER $USER
ENV HOME="/home/$USER"
WORKDIR $HOME

RUN mv .bashrc .bashrc.bak
# RUN mv .bash_profile .bash_profile.bak
WORKDIR $HOME/dotfiles
COPY install_home.bash ./
COPY src/ ./src/
ENV TERM=xterm
RUN ./install_home.bash -n
WORKDIR $HOME
