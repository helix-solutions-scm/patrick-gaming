#!/usr/bin/bash
echo "goobie!"
sudo add-apt-repository multiverse -y
sudo dpkg --add-architecture i386
sudo apt update -y
sudo apt install steamcmd -y
curl "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o "awscliv2.zip"
unzip awscliv2.zip
sudo ./aws/install
mkdir -p ~/.local/share/Daedalic\ Entertainment\ GmbH/Barotrauma/

aws s3 s3://settings_bucket_gruubis/serversettings.xml /home/ubuntu/Steam/steamapps/common/Barotrauma\ Dedicated\ Server/serversettings.xml

echo steam steam/question select "I AGREE" | sudo debconf-set-selections
echo steam steam/license note '' | sudo debconf-set-selections

cat > start_server << EOF
@ShutdownOnFailedCommand 1
@NoPromptForPassword 1
login anonymous 
app_update 1026340 validate
quit
EOF

steamcmd +runscript start_server