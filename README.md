# Go Installer 🐹🚀

This is a Python script that automates the process of installing the latest version of Go on Linux. It downloads the latest version of Go, installs it, and configures the PATH in the shell automatically. 🎉

## Prerequisites 🛠️

- Python 3
- Pip (to install dependencies)
- Internet connection

## How to Use 📖

### 1. Clone the Repository 📂

```bash

1. Clone this repository: 

git clone https://github.com/lupedsagaces/go-installer.git
cd go-installer

2. Install Dependencies 📦

pip install -r requirements.txt
3. Run the Script 🚀

python install_go.py
4. Compile and Configure the linux_install File 🔧
Within the dist folder, the linux_install file has been compiled. To execute it, follow these steps:


cd dist
chmod +x linux_install
./linux_install
Script Description 📝
Function get_latest_go_version
Makes a request to the Go downloads page and parses the HTML content.
Uses XPath to find the element containing the download link for the latest version.
Extracts the file name and constructs the download URL.
Function install_go
Defines the commands to download the file, extract the content, remove previous versions installed, and create symbolic links for Go binaries.
Executes the commands using subprocess.run.
Function update_shell_config
Detects which shell is being used (bash or zsh) and determines the corresponding configuration file (~/.bashrc or ~/.zshrc).
Adds the PATH configuration to the end of the configuration file.
Function main
Calls the functions to get the latest version of Go, install Go, and update the shell configuration.
Contributions 🤝
Contributions are welcome! Feel free to open an issue or submit a pull request.

```

Made with ❤️ by lupedsagaces
