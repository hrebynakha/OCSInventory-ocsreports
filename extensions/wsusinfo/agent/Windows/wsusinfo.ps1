$RegItem= "HKLM:\SOFTWARE\Policies\Microsoft\Windows\WindowsUpdate"
$Properties = ('WUServer', 'TargetGroup', 'TargetGroupEnabled', 'WUStatusServer', 'UpdateServiceUrlAlternate')
$Itmes = Get-ItemProperty $RegItem | Select-Object $Properties
$xml = $null
foreach ($property in $Properties) 
{
    $xml += "<WSUSINFO>`n"
    $xml += "<PROPERTY>"+ $property +"</PROPERTY>`n"
    $xml += "<VALUE>"+ "$($Itmes.$property)" +"</VALUE>`n"
    $xml += "</WSUSINFO>`n"
}
[Console]::WriteLine($xml)