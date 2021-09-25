#    Copyright (C) 2021  Rico M.
#
#    This program is free software; you can redistribute it and/or modify
#    it under the terms of the GNU General Public License 2 as published by
#    the Free Software Foundation.
#
#    This program is distributed in the hope that it will be useful,
#    but WITHOUT ANY WARRANTY; without even the implied warranty of
#    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
#    GNU General Public License 2 for more details.
#
#    You should have received a copy of the GNU General Public License 2 along
#    with this program; if not, write to the Free Software Foundation, Inc.,
#    51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.

#!/bin/bash
green='\033[0;32m'
red='\033[0;31m'
white='\033[0;37m'
reset='\033[0;0m'


datenbank() {
  echo -e ${green}https://github.com/rico-dev/tx-admin-installer
  sleep 5
  clear
  bash <(curl -s https://raw.githubusercontent.com/GermanJag/PHPMyAdminInstaller/main/install.sh)

}




install_options(){
    echo -e  Please select your installation option:
    echo -e  [1] Datenbank.
    read -r choice
    case $choice in
        1 ) installoption=1
            output "You have selected} panel installation only."
            ;;
        2 ) installoption=2
            output "You have selected  panel installation only."
            ;;
        3 ) installoption=3
            output "You have selected wings } installation only."
            ;;
        4 ) installoption=4
            output "You have selected daemon  installation only."
            ;;
        5 ) installoption=5
            output "You have selected L} panel and wings  installation."
            ;;
        6 ) installoption=6
            output "You have selected GACY} panel and daemon installation."
            ;;
        7 ) installoption=7
            output "You have selected to install the standalone SFTP server."
            ;;
        8 ) installoption=8
            output "You have selected to upgrade the panel to L}."
            ;;
        9 ) installoption=9
            output "You have selected to upgrade the panel to L}."
            ;;
        10 ) installoption=10
            output "You have selected to upgrade the panel to _LEGACY}."
            ;;
        11 ) installoption=11
            output "You have selected to upgrade the daemon to EMON_LEGACY}."
            ;;
        12 ) installoption=12
            output "You have selected to migrate daemon $ to wingsNGS}."
            ;;
        13 ) installoption=13
            output "You have selected to upgrade both the panel to L} and migrating to wings INGS}."
            ;;
        14 ) installoption=14
            output "You have selected to upgrade both the panel to EL} and daemon toEGACY}."
            ;;
        15 ) installoption=15
            output "You have selected to upgrade the standalone SFTP."
            ;;
        16 ) installoption=16
            output "You have activated mobile app compatibility."
            ;;
        17 ) installoption=17
            output "You have selected to update the mobile app compatibility."
            ;;
        18 ) installoption=18
            output "You have selected to install or update phpMyAdmin }."
            ;;
        19 ) installoption=19
            output "You have selected to install a Database host."
            ;;
        20 ) installoption=20
            output "You have selected to change Pterodactyl  only."
            ;;
        21 ) installoption=21
            output "You have selected MariaDB root password reset."
            ;;
        22 ) installoption=22
            output "You have selected Database Host information reset."
            ;;
        * ) output "You did not enter a valid selection."
            install_options
    esac
}





txadmin() { 

  echo -e ${green}This is you Database Data. Please save it, you have 15s

  sleep 15

  cd /home/

  wget https://runtime.fivem.net/artifacts/fivem/build_proot_linux/master/4478-469601d22046dcb305d06ba90cc54c93d6b77af8/fx.tar.xz
  
  tar -Jxvf fx.tar.xz

  clear

  ./run.sh +set serverProfile dev_server +set txAdminPort 40120

}


if [[ $EUID -ne 0 ]]; then
   echo "This script must be run as root" 1>&2
   exit 1
fi

install_options

datenbank

txadmin

case $installoption in 
        1) datenbank
             ;;
        2)   webserver_options
             theme_options
             repositories_setup_0.7.19
             required_infos
             firewall
             setup_pterodactyl_0.7.19
             broadcast
             ;;
        3)   repositories_setup
             required_infos
             firewall
             ssl_certs
             install_wings
             broadcast
	     broadcast_database
             ;;
        4)   repositories_setup_0.7.19
             required_infos
             firewall
             ssl_certs
             install_daemon
             broadcast
             ;;
        5)   webserver_options
             repositories_setup
             required_infos
             firewall
             ssl_certs
             setup_pterodactyl
             install_wings
             broadcast
             ;;
        6)   webserver_options
             theme_options
             repositories_setup_0.7.19
             required_infos
             firewall
             setup_pterodactyl_0.7.19
             install_daemon
             broadcast
             ;;
        7)   install_standalone_sftp
             ;;
        8)   upgrade_pterodactyl
             ;;
        9)   upgrade_pterodactyl_1.0
             ;;
        10)  theme_options
             upgrade_pterodactyl_0.7.19
             theme
             ;;
        11)  upgrade_daemon
             ;;
        12)  migrate_wings
             ;;
        13)  upgrade_pterodactyl_1.0
             migrate_wings
             ;;
        14)  theme_options
             upgrade_pterodactyl_0.7.19
             theme
             upgrade_daemon
             ;;
        15)  upgrade_standalone_sftp
             ;;
        16)  install_mobile
             ;;
        17)  upgrade_mobile
             ;;
        18)  install_phpmyadmin
             ;;
        19)  repositories_setup
             install_database
             ;;
        20)  theme_options
             if [ "$themeoption" = "1" ]; then
             	upgrade_pterodactyl_0.7.19
             fi
             theme
            ;;
        21) curl -sSL https://raw.githubusercontent.com/tommytran732/MariaDB-Root-Password-Reset/master/mariadb-104.sh | sudo bash
            ;;
        22) database_host_reset
            ;;
esac