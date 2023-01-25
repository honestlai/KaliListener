#!/bin/bash

###################
#WARNING needs to be saved als LT end of line file
###################

# Install Oh My ZSH, Plugins, & Addons
neofetch
ADDONFILES=/root/.p10k.zsh
if test -f "$ADDONFILES";
  then
    printf "\nOhMyZSH and other addon installations skipped, .p10k.zsh present in root directory\n"
  else
    echo "n" | sh -c "$(curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
    git clone --depth=1 https://github.com/romkatv/powerlevel10k.git ~/.powerlevel10k
    echo 'source ~/.powerlevel10k/powerlevel10k.zsh-theme' >>~/.zshrc
    git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions
    git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting
    mv /tmp/.* /root && mv /tmp/aliases /opt/aliases && mv /tmp/bin /opt
fi


# Set password for VNC

mkdir -p /root/.vnc/
echo $VNCPWD | vncpasswd -f > /root/.vnc/passwd
chmod 600 /root/.vnc/passwd

# Set password for VNC as user kali
mkdir -p /root/.vnc/
echo $VNCPWD | vncpasswd -f > /root/.vnc/passwd
chmod 600 /root/.vnc/passwd

# Start VNC server as user kali
vncserver :0 -rfbport $VNCPORT -geometry $VNCDISPLAY -depth $VNCDEPTH \
  > /dev/null 2>&1 &


echo "#!/bin/sh
autocutsel -fork
xrdb "$HOME/.Xresources"
xsetroot -solid grey
x-terminal-emulator -geometry 80x24+10+10 -ls -title "$VNCDESKTOP Desktop" &
x-window-manager &
# Fix to make GNOME work
export XKL_XMODMAP_DISABLE=1
/etc/X11/Xsession" > /root/.vnc/xstartup
chmod 777 /root/.vnc/xstartup


# MeshAgent installer
MESHFILES=/opt/bin/meshagent.msh
if [[ $MESHDOMAIN  =~ "remoteportal.example.com" ]];
  then
  printf "MeshAgent not configured, agent installation skipped\n"
  else
  if test -f "$MESHFILES";
	then
	  printf "MeshAgent.msh site file present in /opt/bin, new  agent installation skipped\n\n\n" && screen -d -m -S mesh /opt/bin/meshagent
	else
	  cd /opt/bin/ && ./meshinstall.sh https://$MESHDOMAIN $MESHKEY && ./meshagent -uninstall
	  screen -d -m -S mesh /opt/bin/meshagent
	fi
fi


#Socat Listener
cp /usr/share/zoneinfo/$TZ /etc/localtime
alias date='date +"%a, %h %d, %Y  %r"'
screen -d -m -S Receiver socat TCP4-LISTEN:465,reuseaddr,fork EXEC:/opt/bin/multi-shell.sh

#Discord webhook alert if configured
if [[ $DISCORDWH =~ "randomcharacterstring" ]];
  then
    printf "Discord Webhook not configured\n"
  else
    sed -i '1s/^/export WEBHOOK_URL="$DISCORDWH\n/' /opt/bin/discord.sh
fi

# Shell & Path modifications
chsh -s /usr/bin/zsh
echo zsh >> /root/.bashrc

echo -------------------------------
figlet KaliListener
echo -------------------------------
# Start noVNC server as user kali
/usr/share/novnc/utils/novnc_proxy --listen $NOVNCPORT --vnc localhost:$VNCPORT
