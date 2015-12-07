#!/bin/bash

PATH_TO_PLUGIN=$1
MANIFEST_FILES=`find ${PATH_TO_PLUGIN}/ -path ${PATH_TO_PLUGIN}/.build -prune -o -name '*.pp' -print`

echo $(tput bold)$(tput setaf 5)"======================"$(tput sgr0)
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

echo $(tput bold)$(tput setaf 5)"Fuel Plugin clean"$(tput sgr0)
rm -rf $PATH_TO_PLUGIN/.build
echo "$(tput bold)$(tput setaf 3).build folder has been deleted$(tput sgr0)"
rm -rf $PATH_TO_PLUGIN/*.rpm
echo "$(tput bold)$(tput setaf 3)RPM has been deleted$(tput sgr0)"

echo $(tput bold)$(tput setaf 5)"Fuel Plugin test"$(tput sgr0)
/usr/local/bin/fpb --check $PATH_TO_PLUGIN

echo $(tput bold)$(tput setaf 5)"Fuel Plugin BUILD"$(tput sgr0)
/usr/local/bin/fpb --build $PATH_TO_PLUGIN

echo $(tput bold)$(tput setaf 5)"Fuel Plugin RPM"$(tput sgr0)
ls $PATH_TO_PLUGIN/*.rpm
