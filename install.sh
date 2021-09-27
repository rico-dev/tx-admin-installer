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

TxAdmin=v4.5.0
PHPMyAdmin=v5.1.1


datenbank() {
  clear
  bash <(curl -s https://raw.githubusercontent.com/GermanJag/PHPMyAdminInstaller/main/install.sh)

}




tx_options(){
    
    echo -e This Script made by Rico M. https://github.com/rico-dev PHPMyAdmin install script by Julian G. https://github.com/GermanJag
    echo -e  Please select your option:
    echo -e  [1] TxAdmin ${TxAdmin} with Database/PHPMyAdmin ${PHPMyAdmin} 
    echo -e  [2] Only TxAdmin. ${TxAdmin}
    read -r choice
    case $choice in
        1 ) txoption=1

            ;;
        2 ) txoption=2
        
            ;;   
        * ) 
            tx_options
    esac
}





txadmin() { 
  echo -e https://github.com/rico-dev/tx-admin-installer
 
  sleep 15

  cd /home/

  wget https://runtime.fivem.net/artifacts/fivem/build_proot_linux/master/4478-469601d22046dcb305d06ba90cc54c93d6b77af8/fx.tar.xz
  
  tar -Jxvf fx.tar.xz

  clear

  ./run.sh +set serverProfile dev_server +set txAdminPort 40120

}


 if [ "$EUID" -ne 0 ]; then
        echo "Please run as root."
        exit 3
    fi

tx_options

case $txoption in 
        1) datenbank
           echo -e This is you Database Data. Please save it, you have 15s
           txadmin
             ;;
        2) txadmin
             ;;
esac