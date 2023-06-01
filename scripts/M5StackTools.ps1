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
if (-not (Test-Path -Path Core2-for-AWS-IoT-EduKit)) {
  git clone https://github.com/m5stack/Core2-for-AWS-IoT-EduKit.git
}

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

#Import-Module BitsTransfer

# Serial UART Driver
#Start-BitsTransfer -Source "https://www.silabs.com/documents/public/software/CP210x_Universal_Windows_Driver.zip" -Destination CP210x_Universal_Windows_Driver.zip

if (-not (Test-Path -Path CP210x_Universal_Windows_Driver)) {
  Invoke-WebRequest -Uri https://www.silabs.com/documents/public/software/CP210x_Universal_Windows_Driver.zip -OutFile CP210x_Universal_Windows_Driver.zip -UseBasicParsing
  7z x CP210x_Universal_Windows_Driver.zip -o*
  cd CP210x_Universal_Windows_Driver
  PNPUtil.exe /add-driver silabser.inf /install
  rm ../CP210x_Universal_Windows_Driver.zip
}

cd $env:USERPROFILE\desktop\DigiCamp2023

# M5 Burner
#Start-BitsTransfer -Source "https://m5burner.m5stack.com/app/M5Burner-v3-beta-win-x64.zip" -Destination M5Burner-v3-beta-win-x64.zip
if (-not (Test-Path -Path M5Burner-v3-beta-win-x64)) {
  Invoke-WebRequest -Uri https://m5burner.m5stack.com/app/M5Burner-v3-beta-win-x64.zip -OutFile M5Burner-v3-beta-win-x64.zip -UseBasicParsing
  7z x M5Burner-v3-beta-win-x64.zip -o*
  del M5Burner-v3-beta-win-x64.zip
}

# UIFlow
if (-not (Test-Path -Path UIFlow-Desktop-IDE)) {
  #Start-BitsTransfer -Source "https://m5stack.oss-cn-shenzhen.aliyuncs.com/resource/software/UIFlow-Desktop-IDE.zip" -Destination UIFlow-Desktop-IDE.zip
  Invoke-WebRequest -Uri https://m5stack.oss-cn-shenzhen.aliyuncs.com/resource/software/UIFlow-Desktop-IDE.zip -OutFile UIFlow-Desktop-IDE.zip -UseBasicParsing
  7z x UIFlow-Desktop-IDE.zip -o*
  del UIFlow-Desktop-IDE.zip
}

Enable-WindowsOptionalFeature -Online -FeatureName NetFx3 -All
