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

status(){
  clear
  echo -e $green$@'...'$reset
  sleep 1
}

runCommand(){
    COMMAND=$1

    if [[ ! -z "$2" ]]; then
      status $2
    fi

    eval $COMMAND;
    BASH_CODE=$?
    if [ $BASH_CODE -ne 0 ]; then
      echo -e "${red}An error occurred:${reset} ${white}${COMMAND}${reset}${red} returned${reset} ${white}${BASH_CODE}${reset}"
      exit ${BASH_CODE}
    fi
}

function datenbank() {
  echo -e "${green}https://github.com/rico-dev/tx-admin-installer"
  sleep 5
  clear
  runCommand "bash <(curl -s https://raw.githubusercontent.com/GermanJag/PHPMyAdminInstaller/main/install.sh)" "Install Database"

}


function txadmin() { 

  echo -e "${green}This is you Database Data. Please save it, you have 15s"

  sleep 15

  runCommand "cd /home/" "Install TxAdmin please wait..."

  runCommand "wget https://runtime.fivem.net/artifacts/fivem/build_proot_linux/master/4478-469601d22046dcb305d06ba90cc54c93d6b77af8/fx.tar.xz"
  
  runCommand "tar -Jxvf fx.tar.xz"

  clear

  runCommand "./run.sh +set serverProfile dev_server +set txAdminPort 40120"

}


if [[ $EUID -ne 0 ]]; then
   echo "This script must be run as root" 1>&2
   exit 1
fi

datenbank

txadmin