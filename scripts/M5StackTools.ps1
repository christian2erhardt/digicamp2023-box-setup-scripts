Update-SessionEnvironment
cd $env:USERPROFILE\desktop
mkdir DigiCamp2023
cd DigiCamp2023

# Install python
choco install -y python

# Refresh path
refreshenv

# Update pip
python -m pip install --upgrade pip

# Install ML related python packages through pip
pip install numpy
pip install pandas
pip install matplotlib

# Get Visual Studio C++ Redistributables
choco install -y vcredist2015

# Clone Repo
git clone https://github.com/m5stack/Core2-for-AWS-IoT-EduKit.git

# Install VSCode extension

$extensions = 
"platformio.platformio-ide"

$cmd = "code --list-extensions"
Invoke-Expression $cmd -OutVariable output | Out-Null
$installed =$output -split "\s"

foreach ($ext in $extensions) {
  if ($installed.Contains($ext)) {
    Write-Host $ext "already installed." -ForegroundColor Green
  } else {
    Write-Host "Installing" $ext "..." -ForegroundColor Yellow
    code --install-extension $ext
  }
}

# Serial UART Driver
((new-object net.webclient).DownloadFile("https://www.silabs.com/documents/public/software/CP210x_Universal_Windows_Driver.zip", "CP210x_Universal_Windows_Driver.zip"))
7z x CP210x_Universal_Windows_Driver.zip

cd CP210x_Universal_Windows_Driver
PNPUtil.exe /add-driver silabser.inf /install
