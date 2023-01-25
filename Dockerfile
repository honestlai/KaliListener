FROM kalilinux/kali-rolling:latest
LABEL description="Kali Linux with XFCE Desktop via VNC and noVNC in browser. "
LABEL description="WARNING needs to be saved als LT end of line file"


ARG KALI_METAPACKAGE=default
ARG KALI_DESKTOP=xfce
ENV DEBIAN_FRONTEND noninteractive

# Container Variables
ENV USER root
ENV VNCEXPOSE 1
ENV VNCPORT 5900
ENV VNCPWD password
ENV ROOTPW changeme
ENV VNCDISPLAY 1600x900
ENV VNCDEPTH 16
ENV NOVNCPORT 9090
ENV TZ=Pacific/Honolulu
ENV MESHDOMAIN remoteportal.example.com
ENV MESHKEY randomcharacterstring
ENV DISCORDWH randomcharacterstring

# Install kali desktop
RUN apt-get update; \
    apt-get -y upgrade; \
    apt-get -y install kali-linux-${KALI_METAPACKAGE}; \
    apt-get -y install kali-desktop-${KALI_DESKTOP}; \
    apt-get -y install dbus dbus-x11 novnc net-tools x11vnc xvfb; \        
    apt-get clean

# Install custom packages
RUN apt -y update --fix-missing && apt clean; \
    apt-get install -y --no-install-recommends \
        curl sudo apt-transport-https curl crackmapexec crunch dirb dirbuster dnsenum dnsrecon dnsutils dos2unix \
        enum4linux exploitdb figlet ftp git gnupg gobuster golang hashcat hping3 htop hydra impacket-scripts iputils-ping \
        masscan metasploit-framework micro mimikatz nano nasm ncat neofetch netcat-traditional nikto nmap \
        openvpn patator php powersploit proxychains python2 python3 python3-impacket python3-pip \
        recon-ng responder samba samba-client samdump2 screen smbclient smbmap snmp socat sqlmap sslscan sslstrip sudo \
        theharvester tor unzip vim wafw00f weevely wfuzz wget whois wordlists wpscan zsh && \
    apt-get clean && \
    apt-get remove xfce4-power-manager  -y; \
    rm -rf /var/lib/apt/lists/*; \
    curl -sSL https://install.python-poetry.org | python3 -

# Root User
WORKDIR /root
RUN echo 'root:${ROOTPW}' | chpasswd; \
    echo include /usr/share/nano/sh.nanorc > /tmp/.nanorc; \
    echo 'shell /bin/zsh' > /tmp/.screenrc

# History & Aliases
ADD ./conf/history /tmp/.zsh_history
ADD ./conf/aliases /tmp/aliases

# OhMyZSH & Powerlevel10K addons
COPY ./.zshrc /tmp/.zshrc 
COPY ./.p10k.zsh /tmp/.p10k.zsh

# Custom scripts & Meshagent
ADD ./bin /tmp/bin
RUN chmod +x /tmp/bin/* && chmod -x /tmp/bin/*.rc


EXPOSE 465 4444 4445 5900 9090
VOLUME ["/opt/", "/root"]

# Entrypoint
COPY entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh
ENTRYPOINT [ "/entrypoint.sh" ]
