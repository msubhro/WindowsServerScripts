
<# This script will generate event logs based on few specified criterias. The criterias include the Server List, Event Log Name (Ex: System), Log Type (Ex: Critical, Error), Date Range (Ex: Last 7 days). 

After that, it will convert the report to HTML, and will send the report to the specified email address / DL. You can incorporate this to a schedule task , so that you will get this report at regular interval. #>

$date=Get-Date

$date1= $date.ToString("dd-MM-yyyy")

<# Please customize the output file location#>

$path= "C:\EventLog"

$directory= New-Item -ItemType directory -Path "$path\$date1"

<# Please customize the input file location, where server list will be mentioned#>

$serverlist = Get-Content "C:\input\input.txt"

<# Please customize the date range. Here -3 means , last 3 days events would be displayed#>

$End= (get-date).AddDays(-3)

foreach ($server in $serverlist )

{

<# You can customize Logname , and put multiple Lognames. You can also customize event type. Here we have selected all critical and errors from the Application Log in last 3 days.#>
 
$log= Get-WinEvent -LogName "Application" -ComputerName $server| where {$_.LevelDisplayName -eq "Critical" -or $_.LevelDisplayName -eq "Error"} | where {$_.TimeCreated -ge $end} | Select-Object @{label='ID'; expression= {$_.ID}},@{label='Level (1-Critical,2-Error)'; expression= {$_.Level}},@{label='Provider Name'; expression= {$_.ProviderName}},@{label='Log Name'; expression= {$_.LogName}},@{label='Server Name'; expression= {$_.MachineName}},@{label='Time Created'; expression= {$_.TimeCreated}},@{label='Log Container'; expression= {$_.ContainerLog}},@{label='Message'; expression= {$_.Message}}

$log | ConvertTo-Html | Out-File $directory\eventlog.htm -Append

}



$File= "$directory\eventlog.htm"

$bodyText=
@'

Hi Team,

Please find the Critical event and Error Reports from the Application log.

This is an auto generated mail. Please do not reply.


Regards,
It Team

'@


       
#SMTP server name
$smtpServer = "your SMTP Server FQDN"

#Creating a Mail object
$msg = new-object Net.Mail.MailMessage

#Creating SMTP server object
$smtp = new-object Net.Mail.SmtpClient($smtpServer)

#Email structure
$msg.From = "From Server Name"
$msg.To.Add("email address or DL")
$msg.subject = "Email Subject"
$msg.body = $bodyText
       
$att = new-object Net.Mail.Attachment($File)
$msg.Attachments.Add($att) 
   
#Sending email
$smtp.Send($msg) 
 
