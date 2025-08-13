# Go Install 🐹🚀
Essa ferramenta automatiza o processo de instalaçãõ da última versão do Go no linux. Possibilita a instalação e configuração no path automaticamente

1️⃣ Usando Python
Pré-requisitos:

```bash
sudo apt install python3 python3-pip
pip3 install requests lxml
```
Execução:

`python3 linux_install.py`

Para arquitetura amd64 possui um executável em goinstall/dist/linux_install

2️⃣ Usando Perl
Pré-requisitos:

```bash
sudo apt install perl libwww-perl libhtml-tree-perl libfile-homedir-perl
```

Execução:

`perl go_install.pl`

📌 Este script:

Pergunta a arquitetura desejada (amd64 ou arm64)

Baixa a última versão para a arquitetura escolhida

Instala em /usr/local/go

Adiciona o PATH no ~/.bashrc ou ~/.zshrc

3️⃣ Verificando a instalação
Após rodar qualquer um dos scripts:

`go version`

O correto é visualizar algo como, por exemplo:

`go version go1.23.1 linux/amd64`

Made with ❤️ by lupedsagaces
