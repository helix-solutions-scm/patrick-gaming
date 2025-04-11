#!/usr/bin/bash
echo "goobie!"
sudo add-apt-repository multiverse -y
sudo dpkg --add-architecture i386
sudo apt update -y
echo steam steam/question select "I AGREE" | sudo debconf-set-selections
echo steam steam/license note '' | sudo debconf-set-selections
sudo apt install steamcmd unzip -y
curl "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o "awscliv2.zip"
unzip awscliv2.zip
sudo ./aws/install
mkdir -p ~/.local/share/Daedalic\ Entertainment\ GmbH/Barotrauma/
mkdir -p ~/.steam/root
mkdir -p ~/.steam/steam

aws s3 cp s3://settings-bucket-gruubis/serversettings.xml /root/Steam/steamapps/common/Barotrauma\ Dedicated\ Server/serversettings.xml

/usr/games/steamcmd +quit

cat > ~/start_server << EOF
@ShutdownOnFailedCommand 1
@NoPromptForPassword 1
login anonymous 
app_update 1026340 validate
quit
EOF

/usr/games/steamcmd +runscript ~/start_server

/root/Steam/steamapps/common/Barotrauma\ Dedicated\ Server/DedicatedServer