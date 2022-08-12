# src https://fedingo.com/how-to-get-filename-from-path-in-shell-script/#:~:text=How%20to%20Get%20Filename%20from%20Path%20in%20Shell,to%20make%20it%20executable.%204%20Run%20Shell%20Script
#!/bin/bash
input="/home/data.txt"
# extract data.txt
file_name="${input##*/}"
# get .txt
file_extension="${file_name##*.}"
# get data
file="${file_name%.*}"
# print the different variables
echo "Full input file : $input"
echo "Filename only : $file_name"
echo "File extension only: $file_extension"
echo "First part of filename only: $file"
