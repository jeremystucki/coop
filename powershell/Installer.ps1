$version = '2d19d51a185be784935c1bbf3defb6af6d91d9ec'
$url = "https://github.com/STJEREM/coop/archive/$($version).zip"
$out = "$env:TEMP\coop-$($version).zip"
$dest = "$env:TEMP"

function Expand-ZipFile($file, $destination) {
    $shell = New-Object -com shell.application
    $zip = $shell.NameSpace($file)

    foreach($item in $zip.items()) {
        $shell.Namespace($destination).copyhere($item)
    }
}

Invoke-WebRequest -Uri $url -OutFile $out
Expand-ZipFile $out $dest

Get-ChildItem -Path "$dest\coop-$version"

# Todo: implement moving