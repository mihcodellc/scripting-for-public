#!/bin/bash

appid=job_rebuild_freq_cubes
scripts=/home/sisadmin/scripts
logfile=$scripts/$appid.log

namespace="sisense"
current_time=$(date +%s)

echo $current_time #> $logfile

for cronjob in $(kubectl get cronjobs -n $namespace --no-headers -o custom-columns=":metadata.name"  | egrep -i "medrx lockbox 3"); do
  last_schedule=$(kubectl get cronjob $cronjob -n $namespace -o jsonpath='{.status.lastScheduleTime}')
  
  if [ -n "$last_schedule" ]; then
    last_schedule_time=$(date -d "$last_schedule" +%s)
    interval=$(( (current_time - last_schedule_time) / 60 ))

    schedule=$(kubectl get cronjob $cronjob -n $namespace -o jsonpath='{.spec.schedule}')
    echo "CronJob: $cronjob" #>> $logfile
    echo "Schedule: $schedule" #>> $logfile
    echo "Last Scheduled: $last_schedule" #>> $logfile
    echo "Minutes Since Last Run: $interval" #>> $logfile
    echo

    if [ $interval -gt 5 ]; then  # Customize the time interval as per your requirement
      echo "WARNING: CronJob $cronjob has not run according to its schedule." #>> $logfile
	  #kubectl create job -n $namespace $cronjob-manual -from-cronjob=$cronjob
    fi
  else
    echo "CronJob: $cronjob has never been scheduled."
  fi
done

 echo '[{"name": "John", "age": 30}, {"name": "Jane", "age": 25}, {"name": "Doe", "age": 40}]' | jq '.' #array of objects ie {}
 echo '[{"name": "John", "age": 30}, {"name": "Jane", "age": 25}, {"name": "Doe", "age": 40}]' | jq '.[0]' # first objects
 echo '[{"name": "John", "age": 30}, {"name": "Jane", "age": 25}, {"name": "Doe", "age": 40}]' | jq '.[0].name' # first object name fields/key
 echo '[{"name": "John", "age": 30}, {"name": "Jane", "age": 25}, {"name": "Doe", "age": 40}]' | jq '.[] | select (.name == $myvar)' --arg myvar "Doe"
echo '[{"name": "Bello", "age": 40}, {"name": "Jane", "age": 25}, {"name": "Doe", "age": 18}]' | jq '.[] | select (.name | test("doe|Jane";"xin") | not)' # filter names case insensitive
 date -d "2024-09-06T07:02:12.493Z" +"%Y-%m-%d"


##sisense curl
# Request a new session token
new_token=$(curl -X POST "http://linsis-dev.rms-asp.com:30845/api/v1/authentication/login" -H "accept: application/json" -H "Content-Type: application/x-www-form-urlencoded" -H "Authorization:Bearer $crttoken"  -d "username=sisense.dev%40rmsweb.com&password=RM%24S%21s3ns3D3v" | jq -r '.access_token')

# 2. Fetch Elasticubes with failed builds
# -w below is to find any error code and format it as an object {} to avoid error 
curl -X GET \
-H "Authorization: Bearer $new_token" \
-H "Content-Type: application/json" \
-w "{http_code: %{http_code}}\n" "http://linsis-dev.rms-asp.com:30845/api/v1/elasticubes/getElasticubesWithMetadata" |
jq '.[] | select (.title | test("val1|val2|val3";"xin")) |  {name: .title, status: .status, build_status: .lastBuildStatus, cube_oid: .oid}'


#!/bin/dash
#---------------------------------------------------------------------------------------------------------------------------------------------------------------
# Program: job_check_non_freq_cubes.sh
# Author:  Monktar Bello RMS DBA 2024-09-25
# Purpose: if the last build status is failed for frequent elasticubes, try to rebuild them. Sisense won't allow this one to launch a new build when the elacticube is in state of building
# for test("toBefound","atLeastAflag") make sure the flag is mentioned
# url for curl is depending on what API offers and you may have to use different API
#jq is not jquery but jq is a lightweight and flexible command-line JSON processor. ref/tutorial at https://jqlang.github.io/jq/
# allows used this -w "%{http_code}\n" before url passed for curl; it gives error code for search
#---------------------------------------------------------------------------------------------------------------------------------------------------------------

#update 10/28/2024 by Monktar Bello: get all matching cubes without looking at failed or stopped then build on condtions
#                                    #failed ? build. --  not build in last 24hours and not failed ? build

appid=job_check_freq_cubes
scripts=/home/sisadmin/scripts
logfile=$scripts/$appid.log

days_old=4

num_cube=0
max_cube_tobuild=6


# Request a new session token
new_token=$(curl -X POST "http://linsis-dev.rms-asp.com:30845/api/v1/authentication/login" -H "accept: application/json" -H "Content-Type: application/x-www-form-urlencoded" -H "Authorization:Bearer $crttoken"  -d "username=sisense.dev%40rmsweb.com&password=RM%24S%21s3ns3D3v" | jq -r '.access_token')



echo "" >> $logfile
echo "=========================================================================" >> $logfile
echo "`date` START" >> $logfile
echo "" >> $logfile

#debug
echo "$new_token"

# 2. Fetch Elasticubes with failed builds and not stopped
# -w below is to find any error code
matching_cubes=$(
curl -X GET \
-H "Authorization: Bearer $new_token" \
-H "Content-Type: application/json" \
"http://linsis-dev.rms-asp.com:30845/api/v1/elasticubes/getElasticubesWithMetadata" | jq -r '.[] |
select (.title | test("radar|sonar|MedrxAnalytics|Prodwatch|balanc|userwatch";"xin") ) | .oid'
)


#rebuild failed cubes
#cube_oid refers to different key depends on whether you are elasticube or build API
for cube_oid in $matching_cubes; do
#    echo "Rebuilding Elasticube with ID: $cube_oid"
#        echo "Rebuilding Elasticube with ID: $cube_oid" >> $logfile
         echo "Looping cubes ... " >> $logfile
#        echo "\n Try to ReBuild**************************************"

                # check that is still failed and the last is not old than X day and not being built
        response=$(curl -X GET \
        -H "Authorization: Bearer $new_token" \
        -H "Content-Type: application/json" \
        "http://linsis-dev.rms-asp.com:30845/api/v1/elasticubes/getElasticubesWithMetadata" )


        lastBuiltUtc=$(echo "$response" | jq -r '.[] |  select (.oid == $a_oid) | .lastBuiltUtc ' --arg a_oid "$cube_oid")

        lastBuildStatus=$(echo "$response" | jq -r '.[] |  select (.oid == $a_oid) | .lastBuildStatus ' --arg a_oid "$cube_oid")

        status=$(echo "$response" | jq -r '.[] |  select (.oid == $a_oid) | .status[0] ' --arg a_oid "$cube_oid")

        status1=$(echo "$response" | jq -r '.[] |  select (.oid == $a_oid) | .status[1] ' --arg a_oid "$cube_oid")

        cube_title=$(echo "$response" | jq -r '.[] |  select (.oid == $a_oid) |  .title ' --arg a_oid "$cube_oid")


                #echo "Build last time: $lastBuiltUtc have ${lastBuiltUtc:6:13} extract"  # 13 ie digits for datetime
                #if not, then try rebuild
                #lastBuiltUtc=$(echo "$lastBuiltUtc" | grep -o '[0-9]*' | sed 's/ *//g')# source of error of conversion to date


                convert_divider=1000
                lastBuiltUtc=${lastBuiltUtc:6:13} #2>/dev/null # tag as bad substitution in crontab, make sure to use /bin/bash to run it
                quotient=$(echo "$lastBuiltUtc/$convert_divider" | bc) # bc because large number
                #echo  "Here after division $quotient"
                human_readable_date=$(date -d @$quotient +"%Y-%m-%d")
                #echo "$human_readable_date"

                 # Get the current date in YYYY-MM-DD format and compared to last built date
                current_date=$(date +"%Y-%m-%d")
                date_var_epoch=$(date -d "$human_readable_date" +%s) # convert to epoch time
                current_date_epoch=$(date -d "$current_date" +%s)
                difference=$((current_date_epoch - date_var_epoch))
                difference_days=$((difference / 86400))  # Convert the difference from seconds to days ie 86400 seconds in a day


                echo "Check Build of Elasticube with ID: $cube_oid and title: $cube_title and building_status: "$status1" and build_statusfilter: "$status" built $difference_days days ago" >>  $logfile

                # if its not old than less than $days_old days
                if [[ "$status1" == "null"  ]]; then
                        #failed ? build. --  not build in last 24hours and not failed ? build
                        if [[ "$lastBuildStatus" == "failed" || $difference_days -lt $days_old && $difference_days -gt 1 && "$lastBuildStatus" != "failed" ]]; then
                         echo "Rebuilding Elasticube with ID: $cube_oid and title: $cube_title " >> $logfile
                         echo "Rebuilding Elasticube with ID: $cube_oid and title: $cube_title and status1: "$status1" and statusfilter:  "$status" "

                        curl -X POST \
                        -H "Authorization: Bearer $new_token" \
                        -H "Content-Type: application/json" \
                        -w "%{http_code}\n" "http://linsis-dev.rms-asp.com:30845/api/v2/builds" \
                        -d "{ \"datamodelId\": \"$cube_oid\", \"buildType\": \"full\"}" >> $logfile


                        sleep 8
                        echo "\n Build starts************************************"  >> $logfile

                        response=$(curl -X GET \
                        -H "Authorization: Bearer $new_token" \
                        -H "Content-Type: application/json" \
                        "http://linsis-dev.rms-asp.com:30845/api/v1/elasticubes/getElasticubesWithMetadata"
                        )

                        #print status before move to next one
                        echo $response | jq '.[] | select (.oid == $a_oid) |
                        {name: .title, status: .status[0], status1: .status[1] , build_status: .lastBuildStatus, lastBuildTime: .lastBuildTime,
                                lastBuiltUtc: .lastBuiltUtc, lastBuildAttempt: .lastBuildAttempt}' --arg a_oid "$cube_oid"  >> $logfile

                        echo "\n Build ends************************************"  >> $logfile

                        #control how many to buil
                        num_cube=$((num_cube + 1))

                        if [[ "$num_cube" -gt "$max_cube_tobuild" ]]; then
                           exit 0 # 0 ie success
                        fi
                    else
                            echo "The difference is $days_old days or more or built in last 24hours for the cube named $cube_title " >> $logfile
                    fi

                else
                        echo "The cube named $cube_title is being built. " >> $logfile
                fi


done

echo "" >> $logfile
echo "`date` DONE" >> $logfile
