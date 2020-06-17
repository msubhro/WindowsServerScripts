This script will help you to capture registry values for multiple systems. 

Example: You have recently made some changes in the registry settings to a large number of systems. Now, you would like to know what are the registry value present under: "hklm:\SYSTEM\CurrentControlSet\Control\Session Manager\Memory Management", and capture the report for multiple systems. In this case, you need to do two things:

 
1) Prepare an input file with the list of systems. This will be a text file.

2) Within the script, enter the registry key / subkey path.

Ex: "hklm:\SYSTEM\CurrentControlSet\Control\Session Manager\Memory Management".

Please note: You have to maintain the exact format of the key path as mentioned here. Do not write Hkey_Local_Machine, instead write in this format: "hklm:\"

 

Please note: 

This script does not capture the details of subkey's which are present within a given key. It will only capture the values which are directly under the key \ subkey that you have specified in the script.

The output will be extracted in a text file, along with system name. The script will ask you the output file location.

Use Powershell 4.0 or above.

Test before you use it in production environment.

Use at your own risk.
