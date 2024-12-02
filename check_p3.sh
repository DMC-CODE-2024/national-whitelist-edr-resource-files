#!/bin/bash

source ${commonConfigurationFile}

main_module="etl_cdr"
module_name="etl_module"
process_name="sql"

divisor=500000 

dbPassword=$(java -jar ${pass_dypt} spring.datasource.password)

TODAY=$(date +"%Y-%m-%d")

divide_and_round_up() {
  x=$1
  y=$2

  if (( x % y == 0 )); then
    echo $((x / y))
  else
    echo $(((x / y) + 1))
  fi
}

total_final_count=0
check_process_complete() {

totalCount=$(mysql -h$dbIp -P$dbPort $appdbName -u$dbUsername -p${dbPassword} -se "select ifnull(sum(total_output_records),0) from cdr_file_pre_processing_detail where file_type ='O' and source_name ='all' and operator_name ='$1'  and  created_on > '$TODAY' ");

total_final_count=$((total_final_count + totalCount)) 
process_count=$(divide_and_round_up  $totalCount  $divisor)

finished_process=$(mysql -h$dbIp -P$dbPort $edrappdbName -u$dbUsername -p${dbPassword} -se "select COUNT(*) from cdr_file_processed_detail where  operator ='$1'  and created_on > '$TODAY' ");

# Check if process_count equals finished_process
if [[ $process_count -eq $finished_process ]]; then
  echo "Finished" 
else
  # Check if any 'metfone' process is running in the background
  #process_running=$(ps aux | grep -i $operatorName | grep -v grep)
  #if [[ -n "$process_running" ]]; then
  #  echo "Processes are still running."
  #else
  #  echo "Count not matching and no process running, error occurred."
  #fi
  echo "Running."
fi
}

main_function() {

for opr in seatel metfone smart cellcard
 do 	 
    finishStatus='Finished'
    process=$(check_process_complete  $opr)
    if [[ "$process" != "$finishStatus" ]]; then
      echo "Process is Running for $opr"
     return
    fi  
 done
 
  if [[ $total_final_count -eq 0 ]]; then
      echo "No Process Run"
   else  
     echo "Completed"
  fi  
 
}

main_function

exit 0;


