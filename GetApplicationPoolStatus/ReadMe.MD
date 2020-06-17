This script checks all the IIS servers which are specified in the input file, and get the application pool status. It then exports the result in CSV and HTML file format. Finally, the script sends the result in email, attaching both the files.

For best result, customize the script and incorporate it with Windows Task scheduler. The source server should be Windows Server 2012 R2.


Customizations required :

1) Location of the input file: It should be a TXT file.

2) Location of the output folder : It creates date wise subfolder while exporting the output, under the main folder that you specify. Under the subfolder, it exports the output in CSV and HTML format.

3) Email Configuration.


Use PowerShell 4.0 or higer version.

Test before you use, and use at your own risk.

Question / Concern / Feedback: Please post your comment.
