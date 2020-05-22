# Set the base image
FROM steamcmd/steamcmd:ubuntu-18

# Set environment variables
ENV USER csgo
ENV HOME /data

# Create the application user
#RUN useradd -m -d $HOME $USER

# Create the default directories
RUN mkdir -p $HOME/$USER

# switch to user and directory
#USER $USER
WORKDIR $HOME/$USER

# Download game server
RUN steamcmd +login anonymous +force_install_dir $HOME/$USER +app_update 740 validate +quit

# Expose the default ports
EXPOSE 27015/udp 27015/tcp

# Set default container command
CMD $HOME/$USER/srcds_run -game csgo -console -usercon -nobots -maxplayers_override 30 +mp_autoteambalance 0 +tickrate 128 +game_type 0 +game_mode 1 +mapgroup mg_bomb +ip 0.0.0.0 +exec csgoserver.cfg
