$InstallDir="C:\miniconda"

Write-Host "`nDownloading Miniconda Installer...`n"
(New-Object System.Net.WebClient).DownloadFile("https://repo.anaconda.com/miniconda/Miniconda3-latest-Windows-x86_64.exe", "$pwd\Miniconda_Install.exe")

Write-Host "Installing Miniconda...`n"
Start-Process Miniconda_Install.exe "/S /AddToPath=0 /D=$InstallDir" -Wait

