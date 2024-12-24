# Initial GitHub.com connectivity check with 1 second timeout
$canConnectToGitHub = Test-Connection github.com -Count 1 -Quiet -TimeoutSeconds 1

function Update-PowerShell 
{
    if (-not $global:canConnectToGitHub) 
    {
        Write-Host "Skipping PowerShell update check due to GitHub.com not responding within 1 second." -ForegroundColor Yellow
        return
    }

    try 
    {
        Write-Host "Checking for PowerShell updates..." -ForegroundColor Cyan
        $updateNeeded = $false
        $currentVersion = $PSVersionTable.PSVersion.ToString()
        $gitHubApiUrl = "https://api.github.com/repos/PowerShell/PowerShell/releases/latest"
        $latestReleaseInfo = Invoke-RestMethod -Uri $gitHubApiUrl
        $latestVersion = $latestReleaseInfo.tag_name.Trim('v')
        if ($currentVersion -lt $latestVersion) 
        {
            $updateNeeded = $true
        }

        if ($updateNeeded) 
        {
            Write-Host "Updating PowerShell..." -ForegroundColor Yellow
            winget upgrade "Microsoft.PowerShell" --accept-source-agreements --accept-package-agreements
            Write-Host "PowerShell has been updated. Please restart your shell to reflect changes" -ForegroundColor Magenta
        } else 
        {
            Write-Host "Your PowerShell is up to date." -ForegroundColor Green
        }
    } catch 
    {
        Write-Error "Failed to update PowerShell. Error: $_"
    }
}
# Update-PowerShell
Invoke-Expression clear
Invoke-Expression (&starship init powershell)
Invoke-Expression (& { (zoxide init powershell --cmd cd | Out-String) })

function nvim_lazy()
{
  $env:NVIM_APPNAME="nvim-lazy"
  nvim $args
}

function nvims()
{
  $items = "default", "nvim-lazy"
  $config = $items | fzf --prompt=" Neovim Config  " --height=~50% --layout=reverse --border --exit-0

  if ([string]::IsNullOrEmpty($config))
  {
    Write-Output "Nothing selected"
    break
  }
 
  if ($config -eq "default")
  {
    $config = ""
  }

  $env:NVIM_APPNAME=$config
  nvim $args
}

function devenv()
{
    #$vsPath = &(Join-Path ${env:ProgramFiles(x86)} "\Microsoft Visual Studio\Installer\vswhere.exe") -property installationpath
    #Import-Module (Get-ChildItem $vsPath -Recurse -File -Filter Microsoft.VisualStudio.DevShell.dll).FullName
    #Enter-VsDevShell -VsInstallPath $vsPath -SkipAutomaticLocation -DevCmdArguments "-arch=x64 -host_arch=x64"
    #Hardcode these since using the provided method takes multiple seconds to apply
    $env:INCLUDE = "C:\Program Files\Microsoft Visual Studio\2022\Community\VC\Tools\MSVC\14.38.33130\include;C:\Program Files\Microsoft Visual Studio\2022\Community\VC\Tools\MSVC\14.38.33130\ATLMFC\include;C:\Program Files\Microsoft Visual Studio\2022\Community\VC\Auxiliary\VS\include;C:\Program Files (x86)\Windows Kits\10\include\10.0.22621.0\ucrt;C:\Program Files (x86)\Windows Kits\10\\include\10.0.22621.0\\um;C:\Program Files (x86)\Windows Kits\10\\include\10.0.22621.0\\shared;C:\Program Files (x86)\Windows Kits\10\\include\10.0.22621.0\\winrt;C:\Program Files (x86)\Windows Kits\10\\include\10.0.22621.0\\cppwinrt;C:\Program Files (x86)\Windows Kits\NETFXSDK\4.8\include\um"
    $env:LIB = "C:\Program Files\Microsoft Visual Studio\2022\Community\VC\Tools\MSVC\14.38.33130\ATLMFC\lib\x64;C:\Program Files\Microsoft Visual Studio\2022\Community\VC\Tools\MSVC\14.38.33130\lib\x64;C:\Program Files (x86)\Windows Kits\NETFXSDK\4.8\lib\um\x64;C:\Program Files (x86)\Windows Kits\10\lib\10.0.22621.0\ucrt\x64;C:\Program Files (x86)\Windows Kits\10\\lib\10.0.22621.0\\um\x64;C:\Users\tyler\.cargo\lib\"
    $env:LIBPATH = "C:\Program Files\Microsoft Visual Studio\2022\Community\VC\Tools\MSVC\14.38.33130\ATLMFC\lib\x64;C:\Program Files\Microsoft Visual Studio\2022\Community\VC\Tools\MSVC\14.38.33130\lib\x64;C:\Program Files\Microsoft Visual Studio\2022\Community\VC\Tools\MSVC\14.38.33130\lib\x86\store\references;C:\Program Files (x86)\Windows Kits\10\UnionMetadata\10.0.22621.0;C:\Program Files (x86)\Windows Kits\10\References\10.0.22621.0;C:\Windows\Microsoft.NET\Framework64\v4.0.30319"
    $env:Path += "C:\Program Files\Microsoft Visual Studio\2022\Community\VC\Tools\MSVC\14.38.33130\bin\HostX64\x64;"
    $env:Path += "C:\Program Files\Microsoft Visual Studio\2022\Community\Common7\IDE\VC\VCPackages;"
    $env:Path += "C:\Program Files\Microsoft Visual Studio\2022\Community\Common7\IDE\CommonExtensions\Microsoft\TestWindow;"
    $env:Path += "C:\Program Files\Microsoft Visual Studio\2022\Community\Common7\IDE\CommonExtensions\Microsoft\TeamFoundation\Team Explorer;"
    $env:Path += "C:\Program Files\Microsoft Visual Studio\2022\Community\MSBuild\Current\bin\Roslyn;"
    $env:Path += "C:\Program Files\Microsoft Visual Studio\2022\Community\Team Tools\Performance Tools\x64;"
    $env:Path += "C:\Program Files\Microsoft Visual Studio\2022\Community\Team Tools\Performance Tools;"
    $env:Path += "C:\Program Files (x86)\Microsoft Visual Studio\Shared\Common\VSPerfCollectionTools\vs2019\\x64;"
    $env:Path += "C:\Program Files (x86)\Microsoft Visual Studio\Shared\Common\VSPerfCollectionTools\vs2019\;"
    $env:Path += "C:\Program Files (x86)\Microsoft SDKs\Windows\v10.0A\bin\NETFX 4.8 Tools\x64\;"
    $env:Path += "C:\Program Files\Microsoft Visual Studio\2022\Community\Common7\IDE\CommonExtensions\Microsoft\FSharp\Tools;"
    $env:Path += "C:\Program Files\Microsoft Visual Studio\2022\Community\Team Tools\DiagnosticsHub\Collector;"
    $env:Path += "C:\Program Files (x86)\Windows Kits\10\bin\10.0.22621.0\\x64;"
    $env:Path += "C:\Program Files (x86)\Windows Kits\10\bin\\x64;"
    $env:Path += "C:\Program Files\Microsoft Visual Studio\2022\Community\\MSBuild\Current\Bin\amd64;"
    $env:Path += "C:\Windows\Microsoft.NET\Framework64\v4.0.30319;"
    $env:Path += "C:\Program Files\Microsoft Visual Studio\2022\Community\Common7\IDE\;"
    $env:Path += "C:\Program Files\Microsoft Visual Studio\2022\Community\Common7\Tools\;"
    $env:Path += "C:\Program Files\Microsoft Visual Studio\2022\Community\Common7\IDE\CommonExtensions\Microsoft\CMake\CMake\bin;"
    $env:Path += "C:\Program Files\Microsoft Visual Studio\2022\Community\Common7\IDE\CommonExtensions\Microsoft\CMake\Ninja;"
    $env:Path += "C:\Program Files\Microsoft Visual Studio\2022\Community\Common7\IDE\VC\Linux\bin\ConnectionManagerExe"
}
Invoke-Expression devenv

function invoke-profile()
{
    & $profile
}

function touch($file) 
{ 
    "" | Out-File $file -Encoding ASCII 
}

function grep($regex, $dir) 
{
    if ( $dir ) 
    {
        Get-ChildItem $dir | select-string $regex
        return
    }
    $input | select-string $regex
}

function which($name) 
{
    Get-Command $name | Select-Object -ExpandProperty Definition
}

function Get-PubIP { (Invoke-WebRequest http://ifconfig.me/ip).Content }

# System Utilities
function admin {
    if ($args.Count -gt 0) {
        $argList = "& '$args'"
        Start-Process wt -Verb runAs -ArgumentList "pwsh.exe -NoExit -Command $argList"
    } else {
        Start-Process wt -Verb runAs
    }
}

# Set UNIX-like aliases for the admin command, so sudo <command> will run the command with elevated rights.
Set-Alias -Name sudo -Value admin

function Eza {
    [alias('ls')]
    param(
        [string]$Path = "." # path for ls
    )

    eza.exe -lab --group-directories-first --git --icons $Path
}
