import requests
from lxml import html
import os
import subprocess
import platform

def get_latest_go_version():
    url = 'https://go.dev/dl/'
    response = requests.get(url)
    if response.status_code != 200:
        raise Exception(f"Failed to load page {url}")

    tree = html.fromstring(response.content)
    xpath = '/html/body/main/article/div[1]/a[4]/div[3]/span'
    download_span = tree.xpath(xpath)

    if not download_span:
        raise Exception("Failed to find the download link span")

    download_file = download_span[0].text
    download_url = f"https://go.dev/dl/{download_file}"

    return download_url, download_file

def install_go(download_url, download_file, install_dir='/usr/local/go'):
    commands = [
        f"wget {download_url} -O /tmp/{download_file}",
        f"sudo rm -rf {install_dir}",
        f"sudo tar -C /usr/local -xzf /tmp/{download_file}",
        f"sudo ln -sf /usr/local/go/bin/go /usr/bin/go",
        f"sudo ln -sf /usr/local/go/bin/gofmt /usr/bin/gofmt"
    ]

    for command in commands:
        subprocess.run(command, shell=True, check=True)

def update_shell_config():
    shell = os.getenv('SHELL')
    home_dir = os.path.expanduser("~")
    
    if "zsh" in shell:
        rc_file = os.path.join(home_dir, ".zshrc")
    else:
        rc_file = os.path.join(home_dir, ".bashrc")

    go_path = "\n# Go configuration\nexport PATH=$PATH:/usr/local/go/bin\nexport PATH=$PATH:~/go/bin\n"
    

    with open(rc_file, "a") as file:
        file.write(go_path)
        file.write(go)



def main():
    download_url, download_file = get_latest_go_version()
    install_go(download_url, download_file)
    update_shell_config()
    print("Go has been installed successfully and shell configuration has been updated!")

if __name__ == "__main__":
    main()
