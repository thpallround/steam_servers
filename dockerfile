FROM ubuntu

RUN apt-get update && apt-get dist-upgrade -y
RUN apt-get install -y lib32gcc1 libfontconfig1 libpangocairo-1.0-0 libnss3 libgconf2-4 libxi6 libxcursor1 libxss1 libxcomposite1 libasound2 libxdamage1 libxtst6 libatk1.0-0 libxrandr2 curl

ENV USER_NAME steam
ENV RUN_SCRIPT mordhau_steamscript.txt

RUN useradd -m USER_NAME &&\
    su - USER_NAME &&\
    mkdir -p /home/USER_NAME/steamcmd &&\
    cd /home/USER_NAME/steamcmd &&\
    curl -sqL "https://steamcdn-a.akamaihd.net/client/installer/steamcmd_linux.tar.gz" | tar zxvf -

WORKDIR /home/USER_NAME/steamcmd

USER USER_NAME

ENTRYPOINT ["./steamcmd.sh +login anonymous +runscript mordhau_steamscript.txt"]