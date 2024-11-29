#!/bin/bash
. ~/.bash_profile

source ${commonConfigurationFile} 2>/dev/null

dbPassword=$(java -jar  ${pass_dypt}/pass_dypt.jar spring.datasource.password)

conn="mysql -h${dbIp} -P${dbPort} -u${dbUsername} -p${dbPassword} ${appdbName}"

`${conn} <<EOFMYSQL
INSERT IGNORE INTO cfg_feature_alert (alert_id,DESCRIPTION,feature) VALUES('alert1209','DB connection failed while getting DB configuration value','national_whitelist');
INSERT IGNORE INTO cfg_feature_alert (alert_id,DESCRIPTION,feature) VALUES('alert013','DB Issue <e>','national_whitelist');
INSERT IGNORE INTO cfg_feature_alert (alert_id,DESCRIPTION,feature) VALUES('alert016','Error in national_whitelist <e>','national_whitelist');
INSERT IGNORE INTO cfg_feature_alert (alert_id,DESCRIPTION,feature) VALUES('alert017',"In Post Amnesty period GDCE flag can't be off. Please check.",'national_whitelist');

INSERT IGNORE INTO feature_rule(feature,grace_action,NAME,post_grace_action,rule_order,user_type,failed_rule_action_grace,failed_rule_action_post_grace,output,rule_message,modified_by) VALUES('national_whitelist','','CUSTOM_GDCE','',2,'default','','','','Rule message for CUSTOM_GDCE','system');
INSERT IGNORE INTO feature_rule(feature,grace_action,NAME,post_grace_action,rule_order,user_type,failed_rule_action_grace,failed_rule_action_post_grace,output,rule_message,modified_by) VALUES('national_whitelist','','LOCAL_MANUFACTURER','',3,'default','','','','Rule message for LOCAL_MANUFACTURER','system');
INSERT IGNORE INTO feature_rule(feature,grace_action,NAME,post_grace_action,rule_order,user_type,failed_rule_action_grace,failed_rule_action_post_grace,output,rule_message,modified_by) VALUES('national_whitelist','','IMEI_ALPHANUMERIC','',6,'default','','','','Rule message for IMEI_ALPHANUMERIC','system');
INSERT IGNORE INTO feature_rule(feature,grace_action,NAME,post_grace_action,rule_order,user_type,failed_rule_action_grace,failed_rule_action_post_grace,output,rule_message,modified_by) VALUES('national_whitelist','','IMEI_LENGTH_NATIONAL_WHITELIST','',7,'default','','','','Rule message for IMEI_LENGTH_NATIONAL_WHITELIST','system');
INSERT IGNORE INTO feature_rule(feature,grace_action,NAME,post_grace_action,rule_order,user_type,failed_rule_action_grace,failed_rule_action_post_grace,output,rule_message,modified_by) VALUES('national_whitelist','','IMEI_NULL','',5,'default','','','','Rule message for IMEI_NULL','system');
INSERT IGNORE INTO feature_rule(feature,grace_action,NAME,post_grace_action,rule_order,user_type,failed_rule_action_grace,failed_rule_action_post_grace,output,rule_message,modified_by) VALUES('national_whitelist','','TYPE_APPROVED','',1,'default','','','','Rule message for TYPE_APPROVED','system');
INSERT IGNORE INTO feature_rule(feature,grace_action,NAME,post_grace_action,rule_order,user_type,failed_rule_action_grace,failed_rule_action_post_grace,output,rule_message,modified_by) VALUES('national_whitelist','','VALID_TAC','',4,'default','','','','Rule message for VALID_TAC','system');

INSERT IGNORE INTO rule (DESCRIPTION,NAME,output,state,modified_by) VALUES('Description for CUSTOM_GDCE','CUSTOM_GDCE','','Enabled','Admin');
INSERT IGNORE INTO rule (DESCRIPTION,NAME,output,state,modified_by) VALUES('Description for LOCAL_MANUFACTURER','LOCAL_MANUFACTURER','','Enabled','Admin');
INSERT IGNORE INTO rule (DESCRIPTION,NAME,output,state,modified_by) VALUES('Description for IMEI_ALPHANUMERIC','IMEI_ALPHANUMERIC','','Enabled','Admin');
INSERT IGNORE INTO rule (DESCRIPTION,NAME,output,state,modified_by) VALUES('Description for IMEI_LENGTH_NATIONAL_WHITELIST','IMEI_LENGTH_NATIONAL_WHITELIST','','Enabled','Admin');
INSERT IGNORE INTO rule (DESCRIPTION,NAME,output,state,modified_by) VALUES('Description for IMEI_NULL','IMEI_NULL','','Enabled','Admin');
INSERT IGNORE INTO rule (DESCRIPTION,NAME,output,state,modified_by) VALUES('Description for TYPE_APPROVED','TYPE_APPROVED','','Enabled','Admin');
INSERT IGNORE INTO rule (DESCRIPTION,NAME,output,state,modified_by) VALUES('Description for VALID_TAC','VALID_TAC','','Enabled','Admin');

INSERT IGNORE INTO sys_param (DESCRIPTION,tag,TYPE,VALUE,ACTIVE,feature_name,remark,user_type,modified_by) VALUES ('NWLOnlineAPICheck for source NWL','NWLOnlineAPICheck',0,'false',1,'NationalWhitelist','','','');
INSERT IGNORE INTO sys_param (description,tag,type,value,active,feature_name,remark,user_type,modified_by) VALUES ('Date on which the Grace Period will end in CEIR System.','GRACE_PERIOD_END_DATE',1,'2024-09-01',0,'EDR','','system','system');
INSERT IGNORE INTO sys_param (DESCRIPTION,tag,TYPE,VALUE,ACTIVE,feature_name,remark,user_type,modified_by) VALUES ('latest date when national whitelist process for unique imei ran','app_nw_unique_imei_last_run_time',0,'',1,'NationalWhitelist_CDR','','system','system');
INSERT IGNORE INTO sys_param (DESCRIPTION,tag,TYPE,VALUE,ACTIVE,feature_name,remark,user_type,modified_by) VALUES ('latest date when foreign whitelist process for unique imei ran','app_nw_unique_foreign_imei_last_run_time',0,'',1,'NationalWhitelist_CDR','','system','system');
INSERT IGNORE INTO sys_param (DESCRIPTION,tag,TYPE,VALUE,ACTIVE,feature_name,remark,user_type,modified_by) VALUES ('latest date when foreign whitelist process for imei with different msisdn ran','app_nw_foreign_unique_imei_diff_msisdn_last_run_time',0,'',1,'NationalWhitelist_CDR','','system','system');
INSERT IGNORE INTO app.sys_param (DESCRIPTION,tag,TYPE,VALUE,ACTIVE,feature_name,remark,user_type,modified_by) VALUES ('latest date when edr national whitelist process for unique imei ran','app_edr_nw_unique_foreign_imei_last_run_time',0,'',1,'NationalWhitelist_EDR','','system','system');

INSERT IGNORE INTO feature_rule(feature,grace_action,NAME,post_grace_action,rule_order,user_type,failed_rule_action_grace,failed_rule_action_post_grace,output,rule_message,modified_by) VALUES('foreign_whitelist','','CUSTOM_GDCE','',2,'default','','','','Rule message for CUSTOM_GDCE','system');
INSERT IGNORE INTO feature_rule(feature,grace_action,NAME,post_grace_action,rule_order,user_type,failed_rule_action_grace,failed_rule_action_post_grace,output,rule_message,modified_by) VALUES('foreign_whitelist','','LOCAL_MANUFACTURER','',3,'default','','','','Rule message for LOCAL_MANUFACTURER','system');
INSERT IGNORE INTO feature_rule(feature,grace_action,NAME,post_grace_action,rule_order,user_type,failed_rule_action_grace,failed_rule_action_post_grace,output,rule_message,modified_by) VALUES('foreign_whitelist','','IMEI_ALPHANUMERIC','',6,'default','','','','Rule message for IMEI_ALPHANUMERIC','system');
INSERT IGNORE INTO feature_rule(feature,grace_action,NAME,post_grace_action,rule_order,user_type,failed_rule_action_grace,failed_rule_action_post_grace,output,rule_message,modified_by) VALUES('foreign_whitelist','','IMEI_LENGTH_NATIONAL_WHITELIST','',7,'default','','','','Rule message for IMEI_LENGTH_NATIONAL_WHITELIST','system');
INSERT IGNORE INTO feature_rule(feature,grace_action,NAME,post_grace_action,rule_order,user_type,failed_rule_action_grace,failed_rule_action_post_grace,output,rule_message,modified_by) VALUES('foreign_whitelist','','IMEI_NULL','',5,'default','','','','Rule message for IMEI_NULL','system');
INSERT IGNORE INTO feature_rule(feature,grace_action,NAME,post_grace_action,rule_order,user_type,failed_rule_action_grace,failed_rule_action_post_grace,output,rule_message,modified_by) VALUES('foreign_whitelist','','TYPE_APPROVED','',1,'default','','','','Rule message for TYPE_APPROVED','system');
INSERT IGNORE INTO feature_rule(feature,grace_action,NAME,post_grace_action,rule_order,user_type,failed_rule_action_grace,failed_rule_action_post_grace,output,rule_message,modified_by) VALUES('foreign_whitelist','','VALID_TAC','',4,'default','','','','Rule message for VALID_TAC','system');


EOFMYSQL`



echo "********************Thank You DB Process is completed now*****************"
