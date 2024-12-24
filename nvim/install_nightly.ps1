if (!([Security.Principal.WindowsPrincipal][Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole]::Administrator)) {
    Start-Process pwsh.exe -Verb RunAs "-NoProfile -ExecutionPolicy Bypass -Command `"cd '$pwd'; & '$PSCommandPath';`"";
    exit;
}

$source = 'https://github.com/neovim/neovim/releases/download/nightly/nvim-win64.zip'
$path = [Environment]::GetFolderPath("LocalApplicationData")
$destination = "$path\nvim\nvim-win64.zip" 
Invoke-WebRequest $source -OutFile $destination
Remove-Item "$path\nvim\nvim-win64" -Recurse
[IO.Compression.Zipfile]::ExtractToDirectory($destination, "$path\nvim\nvim-win64")
Remove-Item $destination

$source_dir = "$path\nvim\nvim-win64\*"
$program_files = [Environment]::GetFolderPath("ProgramFiles")
$install_dir = "$program_files\Neovim"
Remove-Item $install_dir -Recurse
Copy-Item -Path $source_dir -Destination $install_dir -Recurse
Remove-Item $source_dir -Recurse