#!/bin/bash
set -x
conffile=/u01/eirsapp/configuration/configuration.properties

#take back up of existing release
tar -xzvf national_whitelist_edr_1.0.0.tar.gz >>national_whitelist_edr_1.0.0_untar_log.txt
mkdir -p ${APP_HOME}/national_whitelist_module/national_whitelist_edr
mkdir -p ${LOG_HOME}/national_whitelist_module/national_whitelist_edr


mv national_whitelist_edr_1.0.0/national_whitelist_edr_1.0.0.jar ${RELEASE_HOME}/binary/
#mv national_whitelist_edr_1.0.0/log4j2.xml ${RELEASE_HOME}/global_config
mv national_whitelist_edr_1.0.0/*  ${APP_HOME}/national_whitelist_module/national_whitelist_edr/

cd ${APP_HOME}/national_whitelist_module/national_whitelist_edr
ln -sf ${RELEASE_HOME}/binary/national_whitelist_edr_1.0.0.jar national_whitelist_edr.jar
ln -sf ${RELEASE_HOME}/global_config/log4j2.xml log4j2.xml

chmod +x *.sh


echo "++++++++++++Application Installation completed+++++++++++"
