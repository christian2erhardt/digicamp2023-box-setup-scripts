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
code --install-extension platformio.platformio-ide

# Serial UART Driver
((new-object net.webclient).DownloadString("https://www.silabs.com/documents/public/software/CP210x_Universal_Windows_Driver.zip", "CP210x_Universal_Windows_Driver.zip"))
7z x CP210x_Universal_Windows_Driver.zip

cd CP210x_Universal_Windows_Driver
PNPUtil.exe /add-driver silabser.inf /install
