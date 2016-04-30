function Coop {
    [CmdletBinding()]
    param (
        [switch] $Version,
        [switch] $Upgrade,
        [string] $location = "",
        [string] $menuFilter = ""
    )

    function Get-Unix-Midnight() {
        return [int][double]::Parse($(Get-Date -date (Get-Date -Hour 0 -Minute 00 -Second 00 -Millisecond 0000).ToUniversalTime()-uformat %s))
    }

    if ($Version -eq $true) {
        $module = Get-Module Coop
        Write-Host "STJEREM/coop $($module.Version)"
        Return
    }

    if ($Upgrade -eq $true) {
        Write-Host "Upgrading to latest version..."
        Invoke-WebRequest -OutFile CoopInstaller.ps1 -Uri https://raw.githubusercontent.com/STJEREM/coop/feature/latest-version/client/powershell/Installer.ps1
        .\CoopInstaller.ps1
        Remove-Item .\CoopInstaller.ps1
        Return
    }

    if ($location -eq "") {
        $location = $(Read-Host "Location")
    }

    $timestamp = Get-Unix-Midnight

    $client = New-Object System.Net.WebClient
    $url = "https://themachine.jeremystucki.com/api/v1/coop/menus/$($location)/$($timestamp)"

    $response = $client.DownloadString($url)
    $json = ConvertFrom-Json $response

    if ($json.results.count -eq 0) {
        Write-Host -Foreground Red "No menus found for $($location)"
        Return
    }

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