#!/bin/bash
set -x
conffile=/u01/eirsapp/configuration/configuration.properties

#take back up of existing release
echo `tar -czvf ${APP_HOME}/NationalWhitelist_$(date +%Y%m%d).tar.gz  ${APP_HOME}/NationalWhitelist/`


tar -xzvf NationalWhitelistModule_1.1.0.2.tar.gz >>national_whitelist_1.1.0.2_untar_log.txt


mv national-whitelist-1.1.0.jar  ${APP_HOME}/NationalWhitelist/

cd ${APP_HOME}/NationalWhitelist



echo "++++++++++++Application Installation completed+++++++++++"
