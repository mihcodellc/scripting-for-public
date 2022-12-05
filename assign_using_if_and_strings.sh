# Program name: assign using if and strings
# Author : Monktar Bello
# Date: 6/14/2022
# Description
#****what I learn here : compare strings and assign to a variable
#****== to compare
#****`` or $() to get the value of output of a cmd
#****when assign to a variable don\'t precede the name with $
#****no space between the value to be assigned, operator, and the variable ie assignee
ip=`route -n | grep UG | tr -s " " | cut -f 2 -d " "`
ping="/bin/ping"
echo "Checking to see if $ip is up..."
signa=`echo "ready_for_short_term_DIF.txt"`
echo $signa
signa_type=
#$ping -c 5 $ip
                if [ $signa == ready_for_short_term_LOG.txt ]; then
                       signa_type=`echo "LOG"`
                fi
                if [ $signa == ready_for_short_term_FULL.txt ]; then
                       signa_type=$(echo "FULL")
                fi
                if [ $signa == ready_for_short_term_DIFF.txt ]; then
                       signa_type=`echo "DIFF"`
                fi
                t=`echo "bello" | wc -c`
                echo "$signa_type and $t"
                # rm $signa # because the user doen't the right to write file to root on destination directory
                #signa=$(find .  -type f -name "ready_for_short_term_*.txt" | head -n 1)


#https://linuxize.com/post/bash-concatenate-strings/
db='TestDB'
cd /mnt/sqlbackup/sqlprimary/ASP-SQL/MedRx/LOGSHIPPING
echo "${db}_*.trn"
echo $db'_*.trn'

echo "#raw name output"
find -name 'TestDB*.trn' -mtime +1 -exec ls -lth "{}" \; | wc -l
echo "#name cancatenate with literal string variable interpolation output"
find -name "${db}_*.trn" -mtime +1 -exec ls -lth "{}" \; | wc -l
echo "#name from string1string2 output "
find -name $db'_*.trn' -mtime +1 -exec ls -lth "{}" \; | wc -l
~
