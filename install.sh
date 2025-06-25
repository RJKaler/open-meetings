#!/bin/bash -e

#shellcheck disable=all

#Source: https://cwiki.apache.org/confluence/display/openmeetings/tutorials+for+installing+openmeetings+and+tools?preview=/27838216/334761243/Installation%20OpenMeetings%208.0.0%20on%20Ubuntu%2024.04%20lts.pdf
 
log_file="$PWD/server_install.log"

#For repeated updates
update() { sudo apt-get update && sudo apt-get upgrade -y; }
#Abort at error 
error() { echo "Error. Abort!" && exit 1; }

#requirements: java, nano, libre office, ImageMagick, Sox
#ffmpeg, MariaDB

#update before installing packages 
echo "updating system..." 
update

required_install() {
#nano install 
#sudo apt-get install nano -y  &&
update
#java install
#sudo apt-get install openjdk-21-jre openjdk-21-jre-headless -y 
#
yes y | sudo add-apt-repository ppa:libreoffice/ppa &&
update  &&
sudo apt-get install libreoffice -y &&
update &&
sudo apt-get install imagemagick libjpeg62 zlib1g-dev -y &&
update &&
sudo apt-get install sox -y && 
update 
}

echo "installing requirements..."

{ required_install || { error; } } | tee -a "$log_file" 
