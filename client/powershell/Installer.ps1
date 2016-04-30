param (
    [string] $version = (Read-Host "Commit - SHA or Tag")
)

$url = "https://github.com/STJEREM/coop/archive/$($version).zip"
$out = "$env:TEMP\coop-$($version).zip"
$tmp = "$env:TEMP"
$installDir = "$Home\Documents\WindowsPowerShell\Modules"

function Expand-ZipFile($file, $destination) {
    $shell = New-Object -com shell.application
    $zip = $shell.NameSpace($file)

    foreach($item in $zip.items()) {
        $shell.Namespace($destination).copyhere($item)
    }
}

Write-Host "Downloading package..."

Invoke-WebRequest -Uri $url -OutFile $out
Expand-ZipFile $out $tmp

if ((Test-Path $installDir) -eq $false) {
    New-Item -ItemType Directory -Force -Path $installDir | Out-Null
}

if ((Test-Path "$($installDir)\Coop") -eq $true) {
    Write-Host "Removing previous installed version..."
    Remove-Item -Force -Recurse "$($installDir)\Coop"
}

Write-Host "Installing files..."
Copy-Item -Recurse "$($tmp)\coop-$($version)\powershell\Coop" $installDir

Write-Host "Cleaning up..."
Remove-Item -Force $out
Remove-Item -Force -Recurse "$($tmp)\coop-$($version)"

Write-Host ""
Write-Host -Foreground Green "Installation Successful! Type 'Coop' to see available menus."