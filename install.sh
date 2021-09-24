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

  runCommand "bash <(curl -s https://raw.githubusercontent.com/GermanJag/PHPMyAdminInstaller/main/install.sh)" "Install Database"

}


function txadmin() { 

  runCommand "cd /home/" "Install TxAdmin"

  runCommand "wget https://runtime.fivem.net/artifacts/fivem/build_proot_linux/master/4478-469601d22046dcb305d06ba90cc54c93d6b77af8/fx.tar.xz"
  
  runCommand "tar -Jxvf fx.tar.xz"

  clear
  
  set timeout 3

  runCommand "./run.sh +set serverProfile dev_server +set txAdminPort 40120"

}


if [[ $EUID -ne 0 ]]; then
   echo "This script must be run as root" 1>&2
   exit 1
fi

datenbank

txadmin