param (
    [switch]
    $whatIf
)

if (-not $whatIf -and !([Security.Principal.WindowsPrincipal][Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole]::Administrator)) {
    Start-Process pwsh.exe -Verb RunAs "-NoProfile -ExecutionPolicy Bypass -Command `"cd '$pwd'; & '$PSCommandPath';`"";
    exit;
}

$config = Get-Content ./overrides.json | ConvertFrom-Json -AsHashtable

function log($msg) {
    Write-Host "💡 $msg"
}

function Resolve-PathSafe($path) {
    $ExecutionContext.SessionState.Path.GetUnresolvedProviderPathFromPSPath($Path)
}

function defaultPath($pathName) {
    [PSObject] @{
        Link   = Resolve-PathSafe "~/.$($pathName)"
        Target = Resolve-PathSafe $pathName
    }
}

function checkConfig($os, $pathName) {
    if ($config[$os].length -ge 0) {
        if ($config[$os][$pathName] -ne $null) {
            $config[$os][$pathName] | Foreach-Object {
                [PSObject] @{
                    Link   = Resolve-PathSafe ([System.Environment]::ExpandEnvironmentVariables($_))
                    Target = Resolve-PathSafe $pathName
                }
            }
        }
    }
    else {
        defaultPath $pathName
    }
}

function determinePath($path) {
    log "Checking $path..."

    $pathName = $path.Name

    if ($config['windows'][$pathName] -ne $null -and $IsWindows) {
        checkConfig -os 'windows' -pathName $pathName
    }
    elseif ($config['macos'][$pathName] -ne $null -and $IsMacOS) {
        checkConfig -os 'macos' -pathName $pathName
    }
    elseif ($config['linux'][$pathName] -ne $null -and $IsLinux) {
        checkConfig -os 'linux' -pathName $pathName
    }
    else {
        defaultPath $pathName
    }
}

function linkFile($map) {
    if (Test-Path $map.Link) {
        log "Skipping $($map.Link) as it already exists"
        return
    }

    # validate that $map.Target's directory exists and create it if it doesn't
    $targetDirectory = Split-Path $map.Target
    if (-not (Test-Path $targetDirectory)) {
        if ($whatIf) {
            log "Creating directory $targetDirectory"
        }
        else {
            New-Item -ItemType Directory -Path $targetDirectory
        }
    }

    if ($whatIf) {
        log "Linking $($map.Link) to $($map.Target)"
    }
    else {
        if ((Get-Item $map.Target) -is [System.IO.DirectoryInfo] -and $IsWindows) {
            New-Item -Path $_.Link -ItemType Junction -Value $_.Target
        }
        else {
            New-Item -Path $_.Link -ItemType SymbolicLink -Value $_.Target
        }
    }
}

function main {
    Get-ChildItem | Foreach-Object {
        $file = $_

        if ($config.skip_processing -contains $file.Name) { return }
        if ($file.Name.StartsWith('.')) { return }

        determinePath $file | Foreach-Object {
            if ((Test-Path $_.Target) -and (Get-Item $file).LinkType -ne $null) {
                return
            }

            linkFile $_
        }
    }
}

try {
    Push-Location $PSScriptRoot
    main
}
finally {
    Pop-Location
}
