#!/usr/bin/perl
use strict;
use warnings;
use LWP::Simple;
use HTML::TreeBuilder;
use File::HomeDir;

sub escolher_arquitetura {
    print "Escolha a arquitetura Linux para instalar o Go:\n";
    print "1 - amd64 (x86_64)\n";
    print "2 - arm64 (aarch64)\n";
    print "Digite sua escolha [1/2]: ";
    chomp(my $opcao = <STDIN>);

    if ($opcao eq '1') {
        return 'linux-amd64';
    } elsif ($opcao eq '2') {
        return 'linux-arm64';
    } else {
        die "❌ Opção inválida!\n";
    }
}

sub get_latest_go_version {
    my ($arch) = @_;
    my $url = 'https://go.dev/dl/';
    my $html = get($url) or die "❌ Falha ao acessar $url\n";

    my $tree = HTML::TreeBuilder->new;
    $tree->parse_content($html);

    # Procura o primeiro link .tar.gz da arquitetura escolhida
    my @links = $tree->look_down(_tag => 'a', href => qr/\.tar\.gz$/);
    foreach my $link (@links) {
        my $href = $link->attr('href');
        if ($href =~ /$arch\.tar\.gz$/) {
            my $download_file = $href;
            $download_file =~ s!.*/!!; # remove o caminho
            my $download_url = "https://go.dev$href";
            return ($download_url, $download_file);
        }
    }

    die "❌ Não foi possível encontrar a versão para $arch\n";
}

sub install_go {
    my ($download_url, $download_file, $install_dir) = @_;
    $install_dir ||= '/usr/local/go';

    my @commands = (
        "wget $download_url -O /tmp/$download_file",
        "sudo rm -rf $install_dir",
        "sudo tar -C /usr/local -xzf /tmp/$download_file",
        "sudo ln -sf /usr/local/go/bin/go /usr/bin/go",
        "sudo ln -sf /usr/local/go/bin/gofmt /usr/bin/gofmt"
    );

    foreach my $cmd (@commands) {
        print "Executando: $cmd\n";
        system($cmd) == 0 or die "❌ Erro ao executar: $cmd\n";
    }
}

sub update_shell_config {
    my $shell = $ENV{SHELL} || '';
    my $home  = File::HomeDir->my_home;

    my $rc_file = ($shell =~ /zsh/) ? "$home/.zshrc" : "$home/.bashrc";

    my $go_path = "\n# Go configuration\nexport PATH=\$PATH:/usr/local/go/bin\nexport PATH=\$PATH:~/go/bin\n";

    open(my $fh, '>>', $rc_file) or die "❌ Não foi possível abrir $rc_file: $!\n";
    print $fh $go_path;
    close($fh);

    print "✅ Configuração adicionada em $rc_file\n";
}

sub main {
    my $arch = escolher_arquitetura();
    my ($download_url, $download_file) = get_latest_go_version($arch);
    print "📦 Baixando: $download_file\n";
    install_go($download_url, $download_file);
    update_shell_config();
    print "✅ Go instalado com sucesso para arquitetura $arch!\n";
}

main();
