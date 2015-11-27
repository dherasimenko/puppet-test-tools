#!/bin/bash

color () {
    case $2 in
        black)  echo $(tput setaf 0)$1$(tput sgr0)$*;;
        red)    echo $(tput setaf 1)$1$(tput sgr0)$*;;
        green)  echo $(tput setaf 2)$1$(tput sgr0)$*;;
        yellow) echo $(tput setaf 3)$1$(tput sgr0)$*;;
        blue)   echo $(tput setaf 4)$1$(tput sgr0)$*;;
        purple) echo $(tput setaf 5)$1$(tput sgr0)$*;;
        cyan)   echo $(tput setaf 6)$1$(tput sgr0)$*;;
        white)  echo $(tput setaf 7)$1$(tput sgr0)$*;;
        *)      echo 0;;
    esac
}

PATH_TO_PLUGIN=$1
MANIFEST_FILES=`find ${PATH_TO_PLUGIN}/ -path ${PATH_TO_PLUGIN}/.build -prune -o -name '*.pp' -print`

echo $(tput bold)$(tput setaf 5)"Puppet Line Test"$(tput sgr0)
for file in ${MANIFEST_FILES}
do
  echo $(tput bold)"FILE:"$(tput sgr0) $file 
  puppet-lint --fix $file | sed "s/WARNING/$(tput bold)$(tput setaf 3)&$(tput sgr0)/g" |sed "s/ERROR/$(tput bold)$(tput setaf 1)&$(tput sgr0)/g" |sed "s/FIXED/$(tput bold)$(tput setaf 6)&$(tput sgr0)/g"
done

echo $(tput bold)$(tput setaf 5)"Puppet Syntax Test"$(tput sgr0)
for file in ${MANIFEST_FILES}
do
  echo $(tput bold)"FILE:"$(tput sgr0) $file 
  puppet parser validate $file 
done

