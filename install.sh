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
echo "updating system. Preparing for install..." 
update

echo "installing nano..." 

if sudo apt-get install nano -y || error; then 
    echo "successfully installed nano" 
fi

echo "installing java components..."  

if sudo apt-get install openjdk-21-jre openjdk-21-jre-headless -y || error; then 
    echo "successfully installed java packages" 
fi


libre_install() {
#Install libreoffice ppa 
yes y | sudo add-apt-repository ppa:libreoffice/ppa &&
echo "succcessfully added libre office repository"
#Install libre office 
sudo apt-get install libreoffice -y  && 
echo "successfully installed libre office packages"
}

echo "installing libre office components..." 

if libre_install || error; then 
   echo "finished installing libre office" 
fi 

echo "installing imagemagick..." 

if sudo apt-get install imagemagick libjpeg62 zlib1g-dev -y || error; then 
   echo "successfully installed imagemagick" 
fi 

echo "installing sox for audio..." 

if sudo apt-get install sox -y || error; then 
    echo "finished installing sox" 
fi


echo "installing ffmpeg and curl..." 

if sudo apt-get install ffmpeg vlc curl -y || error; then 
    echo "successfully installed ffmpeg and curl" 
fi

echo "installing MariaDB database server..." 

if sudo apt-get install mariadb-server -y || error; then 
    echo "server installed - starting daemon..." 
    if sudo systemctl enable --now mariadb; then
       echo "successfully started server daemon"
   else 
       error 
    fi
fi

echo "finished!"

#required_install() {
#update system
#update
#java install
#yes y | sudo add-apt-repository ppa:libreoffice/ppa &&
#update system
#update  &&
##Install libre office 
#sudo apt-get install libreoffice -y &&
#update system
#update &&
#Install imagemagick
#sudo apt-get install imagemagick libjpeg62 zlib1g-dev -y &&
#update system
#update &&
#Install sox for audio
#sudo apt-get install sox -y && 
#update the system
#update 
#}

#echo "installing requirements..."

#{ required_install || { error; } } | tee -a "$log_file" 
