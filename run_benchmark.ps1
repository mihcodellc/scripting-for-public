##### run a serie of test-01, test-02, test-03, test-04

Write-Host "Executing existing files"

#allow to know execution time
Read-Host -Prompt "Press Enter to continue"
cmd.exe /c 'test-01.bat'
Start-Process -FilePath 'G:\bello\test-02.bat' -NoNewWindow
cmd.exe /c 'test-03.bat'
cmd.exe /c 'test-04.bat'
Write-Host "Executing bello files"

#allow to know execution time
Read-Host -Prompt "Press Enter to continue"

# content of following script: test-bello.ps1
# 1..24 | ForEach-Object {
   # $param = "-o$_"
   # $result = g:\bello\diskspd.exe -w90 -d60 -W30 -si64K -b64K -t24 $param -h -L -Z1M -c100G d:\bello\testfile.dat
   # foreach ($line in $result) {if ($line -like "total:*") { $total=$line; break } }
   # foreach ($line in $result) {if ($line -like "avg.*") { $avg=$line; break } }
   # $mbps = $total.Split("|")[2].Trim()
   # $iops = $total.Split("|")[3].Trim()
   # $latency = $total.Split("|")[4].Trim()
   # $cpu = $avg.Split("|")[1].Trim()
   # "Param $param, $iops iops, $mbps MB/sec, $latency ms, $cpu CPU"
# } | Out-File -FilePath .\benchmark_ASPSQL.txt

.\test-bello.ps1

Write-Host "removing the test file"

#allow to know execution time
Read-Host -Prompt "Press Enter to continue"

#delete test file used by diskspd.exe
Remove-Item -path  d:\bello -recurse