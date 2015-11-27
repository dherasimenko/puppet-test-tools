#!/bin/bash

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

