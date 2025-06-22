#!/bin/bash -e

#shellcheck disable=all
 
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
    sudo apt-get install nano -y  &&
    #java install
    sudo apt-get install openjdk-21-jre openjdk-21-jre-headless -y 
}

echo "installing requirements..."

required_install || error 
