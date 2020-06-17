

$date=Get-Date

$date1= $date.ToString("dd-MM-yyyy")

# Enter the location, where the reports will be stored. Datewise sub folders will be created under this location.

$path= "C:\input"

$directory= New-Item -ItemType directory -Path "$path\$date1"



# This is the location of the input file, which contains server list.


$servers = get-content -path "c:\input\input.txt"


$Results= @()


foreach ($server in $servers) 
{
      
            Import-Module WebAdministration
            
            Set-Location IIS:\AppPools
                              
            $appPoolCollections = dir

            foreach ($apppool in $appPoolCollections)

            {

                $properties= @{ 

                         ServerName= $server
                         AppPoolName = $apppool.Name
                         AppPoolState = $apppool.state
                         AppPoolVersion= $apppool.managedRuntimeVersion

                              }

             $Results+= New-Object psobject -Property $Properties | select-object ServerName,AppPoolName,AppPoolState,AppPoolVersion

             

            }
        } 

        $Results |ft *

        $Results | select-object ServerName,AppPoolName,AppPoolState,AppPoolVersion | export-csv -Path "$directory\AppPoolDetails.csv" -NoTypeInformation

        $Results | ConvertTo-Html | out-file $directory\AppPoolDetails.htm -Append

        $File= "$directory\AppPoolDetails.CSV"

        $File1= "$directory\AppPoolDetails.htm"

$bodyText=
@'

Hi Team,

Please find the Application Pool status of IIS Servers.

This is an auto generated mail. Please do not reply.


Regards,

IT Team

'@


       
#SMTP server name
$smtpServer = "mail.yourdomain.com"

#Creating a Mail object
$msg = new-object Net.Mail.MailMessage

#Creating SMTP server object
$smtp = new-object Net.Mail.SmtpClient($smtpServer)

#Email structure

$msg.From = "ServerName@yourmaildomain.com"

$msg.To.Add("DL@yourmaildomain.com")

$msg.subject = "IIS Server Application Pool Status"

$msg.body = $bodyText

       
$att = new-object Net.Mail.Attachment($File)


$att1 = new-object Net.Mail.Attachment($File1)

#Attaching the CSV file

$msg.Attachments.Add($att) 

#Attaching the HTML file

$msg.Attachments.Add($att1)  
  
#Sending email

$smtp.Send($msg) 

