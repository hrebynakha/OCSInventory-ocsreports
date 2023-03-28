  $getlocaluser = Get-WmiObject -ComputerName 'localhost' -Class Win32_ComputerSystem  | Select-Object -ExpandProperty UserName

$Usr=$getlocaluser -split '\\'

$UserName=$Usr[1]
     
$Path = "$Env:systemdrive\Users\$UserName\AppData\Local\Google\Chrome\User Data\Default\History" 
        if (-not (Test-Path -Path $Path)) { 
            Write-Verbose "[!] Could not find Chrome History for username: $UserName" 
        } 
        $Regex = '(htt(p|s))://([\w-]+\.)+[\w-]+(/[\w- ./?%&=]*)*?' 
        $Value = Get-Content -Path "$Env:systemdrive\Users\$UserName\AppData\Local\Google\Chrome\User Data\Default\History"|Select-String -AllMatches $regex |% {($_.Matches).Value} |Sort -Unique 

        $Value | ForEach-Object { 

    $xml += "<BROWSERHISTORY>`n"
		$xml += "<TYPE>"+ 'Chrome' +"</TYPE>`n"
		$xml += "<USER>"+ $UserName +"</USER>`n"
		$xml += "<DATA>"+ $_ +"</DATA>`n"
		$xml += "</BROWSERHISTORY>`n"

        } 


        

        $Path = "$Env:systemdrive\Users\$UserName\AppData\Roaming\Mozilla\Firefox\Profiles\"
        if (-not (Test-Path -Path $Path)) {
            Write-Verbose "[!] Could not find FireFox History for username: $UserName"
        }
        else {

            $Profiles = Get-ChildItem -Path "$Path\*.default\" -ErrorAction SilentlyContinue
            $Regex = '(htt(p|s))://([\w-]+\.)+[\w-]+(/[\w- ./?%&=]*)*?'
            $Value = Get-Content $Profiles\places.sqlite | Select-String -Pattern $Regex -AllMatches |Select-Object -ExpandProperty Matches |Sort -Unique
            $Value.Value |ForEach-Object {
                $_

        $xml += "<BROWSERHISTORY>`n"
		$xml += "<TYPE>"+ 'Mozzila' +"</TYPE>`n"
		$xml += "<USER>"+ $UserName +"</USER>`n"
		$xml += "<DATA>"+ $_ +"</DATA>`n"
		$xml += "</BROWSERHISTORY>`n"


                }
            }
   


    # [Console]::OutputEncoding = [System.Text.Encoding]::UTF8
[Console]::WriteLine($xml)


      
