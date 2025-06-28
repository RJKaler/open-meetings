#!/bin/bash -e

##shellcheck disable=all

#Source: https://cwiki.apache.org/confluence/display/openmeetings/tutorials+for+installing+openmeetings+and+tools?preview=/27838216/334761243/Installation%20OpenMeetings%208.0.0%20on%20Ubuntu%2024.04%20lts.pdf
 
#log_file="$PWD/server_install.log"

#For repeated updates
#update() { sudo apt-get update && sudo apt-get upgrade -y; }
#Abort at error 
#error() { echo "Error. Abort!" && exit 1; }

#requirements: java, nano, libre office, ImageMagick, Sox
#ffmpeg, MariaDB

#update before installing packages 
#echo "updating system. Preparing for install..." 
#update
#
#echo "installing nano..." 
#
#if sudo apt-get install nano -y || error; then 
#    echo "successfully installed nano" 
#fi
#
#echo "installing java components..."  
#
#if sudo apt-get install openjdk-21-jre openjdk-21-jre-headless -y || error; then 
#    echo "successfully installed java packages" 
#fi


#libre_install() {
#Install libreoffice ppa 
#yes y | sudo add-apt-repository ppa:libreoffice/ppa &&
#echo "succcessfully added libre office repository"
#Install libre office 
#sudo apt-get install libreoffice -y  && 
#echo "successfully installed libre office packages"
#}

#echo "installing libre office components..." 
#
#if libre_install || error; then 
#   echo "finished installing libre office" 
#fi 
#
#echo "installing imagemagick..." 
#
#if sudo apt-get install imagemagick libjpeg62 zlib1g-dev -y || error; then 
#   echo "successfully installed imagemagick" 
#fi 
#
#echo "installing sox for audio..." 
#
#if sudo apt-get install sox -y || error; then 
#    echo "finished installing sox" 
#fi


#echo "installing ffmpeg, vlc  and curl..." 
#
#if sudo apt-get install ffmpeg vlc curl -y || error; then 
#    echo "successfully installed ffmpeg and curl" 
#fi
#
#echo "installing MariaDB database server..." 
#
#if sudo apt-get install mariadb-server -y || error; then 
#    echo "server installed - starting daemon..." 
#    if sudo systemctl enable --now mariadb; then
#       echo "successfully started server daemon"
#   else 
#       error 
#    fi
#fi

echo "Adjusting password for MariaDB to enhance security..." 

while : 
do
    read -resp "Enter database password: " password1
    read -resp "Confirm database password: " password2
    if [ "$password1" = "$password2" ]; then
        db_password="$password1"
        echo "Passwords match. Success!" 
        break 
    else
        echo "Passwords do not match. Please try again."
    fi
done

echo "Now applying password to database" 

if sudo mysqladmin -u root password "$db_password" || error; then 
    echo "successfully set root password" 
fi


echo "==> A database has been installed but the setup is incomplete." 
echo "==> In order for this program to work, the database must fully installed."
echo "==> You can continue setting up the database or exit this program now."
echo "==> Do you want to continue? (y|n) " 
read -rep "==> " ans

if [[ "$ans" =~ ^(y|Y|yes|Yes)$ ]]; then 
    echo "OK - proceeding" 
else 
    echo "OK - exiting script now" 
    exit 0
fi

#
#set password for mysql 

#NOTE: MariaDB password defined by $db_password

