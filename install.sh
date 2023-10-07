#!/bin/bash

# be new
apt-get update

# get software
apt-get install \
	unclutter \
    xorg \
    chromium \
    openbox \
    lightdm \
    locales \
    -y

# dir
mkdir -p /home/kiosk/.config/openbox

# create group
groupadd kiosk

# create user if not exists
id -u kiosk &>/dev/null || useradd -m kiosk -g kiosk -s /bin/bash 

# rights
chown -R kiosk:kiosk /home/kiosk

# remove virtual consoles
if [ -e "/etc/X11/xorg.conf" ]; then
  mv /etc/X11/xorg.conf /etc/X11/xorg.conf.backup
fi
cat > /etc/X11/xorg.conf << EOF
Section "ServerFlags"
    Option "DontVTSwitch" "true"
EndSection
EOF

read -p "Deseja habilitar a rotação da tela? [Y / N]: " var1
array=("normal" "inverted" "right" "left")
# Fazer um case para evitar erros de escrita
if [[ "$var1" == 'y' ]]; then
	read -p "Direção da rotação? [normal / inverted / right / left]: " var2
	if [[ ! -z "$var2" ]]; then
 	if [[ ${array[@]} == "$var2" ]]
	# create config no rotate
	if [ -e "/etc/lightdm/lightdm.conf" ]; then
	  mv /etc/lightdm/lightdm.conf /etc/lightdm/lightdm.conf.backup
	fi
cat > /etc/lightdm/lightdm.conf << EOF
[SeatDefaults]
autologin-user=kiosk
user-session=openbox
display-setup-script=xrandr -o $var2
EOF
	fi
	fi
	fi
fi

# create config no rotate
if [ -e "/etc/lightdm/lightdm.conf" ]; then
  mv /etc/lightdm/lightdm.conf /etc/lightdm/lightdm.conf.backup
fi
cat > /etc/lightdm/lightdm.conf << EOF
[SeatDefaults]
autologin-user=kiosk
user-session=openbox
EOF


# create autostart
if [ -e "/home/kiosk/.config/openbox/autostart" ]; then
  mv /home/kiosk/.config/openbox/autostart /home/kiosk/.config/openbox/autostart.backup
fi
cat > /home/kiosk/.config/openbox/autostart << EOF
#!/bin/bash

unclutter -idle 0.1 -grab -root &

while :
do
  xrandr --auto
  chromium \
    --no-first-run \
    --start-maximized \
    --disable \
    --disable-translate \
    --disable-infobars \
    --disable-suggestions-service \
    --disable-save-password-bubble \
    --disable-session-crashed-bubble \
    --incognito \
    --kiosk "https://neave.tv/"
  sleep 5
done &
EOF

echo "Done!"
