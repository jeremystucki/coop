function Coop {
    [CmdletBinding()]
    param (
        [switch] $Version,
        [string] $location = "",
        [string] $menuFilter = ""
    )

    function Get-Unix-Midnight() {
        return [int][double]::Parse($(Get-Date -date (Get-Date -Hour 0 -Minute 00 -Second 00 -Millisecond 0000).ToUniversalTime()-uformat %s))
    }

    if ($Version -eq $true) {
        Write-Host "STJEREM/coop 0.0.1" -NoNewline
        Exit
    }

    if ($location -eq "") {
        $location = $(Read-Host "Location")
    }

    $timestamp = Get-Unix-Midnight

    $client = New-Object System.Net.WebClient
    $url = "https://themachine.jeremystucki.com/api/v1/coop/menus/$($location)/$($timestamp)"

    $response = $client.DownloadString($url)
    $json = ConvertFrom-Json $response

    Write-Host ""

    foreach ($menu in $json.results) {
        if ($menuFilter -ne "" -and $menu.title -ne $menuFilter) {
            continue;
        }

        Write-Host -NoNewline $menu.title
        Write-Host -Foreground Magenta " $($menu.price)"

        foreach($item in $menu.menu) {
            Write-Host "- $($item)"
        }

        Write-Host ""
    }
}

Export-ModuleMember -Cmdlet Coop