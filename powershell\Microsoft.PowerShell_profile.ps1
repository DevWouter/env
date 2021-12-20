# Place it in `Documents\WindowsPowerShell\Microsoft.PowerShell_profile.ps1`

Import-Module posh-git

function IsConEmu () {
    $exitcode = 0;
    try {
        & ConEmuC.exe --% /IsConEmu
        $exitcode = $LASTEXITCODE
    }
    catch [System.Management.Automation.CommandNotFoundException] {
        $exitcode = 2;
    }

    $IsConEmu = $exitcode -eq 1

    return $IsConEmu
}
# Chocolatey profile
$ChocolateyProfile = "$env:ChocolateyInstall\helpers\chocolateyProfile.psm1"
if (Test-Path($ChocolateyProfile)) {
  Import-Module "$ChocolateyProfile"
}

function Remove-MergedBranches
{
  git branch --merged |
    ForEach-Object { $_.Trim() } |
    Where-Object {$_ -NotMatch "^\*"} |
    Where-Object {-not ( $_ -Like "*master" )} |
    Where-Object {-not ( $_ -Like "*main" )} |
    ForEach-Object { git branch -d $_ }
}
