
# Instalador de quiosque para distribuições Linux baseadas em Debian
Pequeno script de instalação para configurar um quiosque mínimo com Chromium para distribuições Linux baseadas em Debian. Este instalador é fortemente baseado nas excelentes [instruções de Will Haley](http://willhaley.com/blog/debian-fullscreen-gui-kiosk/).

## SO Base
* Configure um Ubuntu mínimo sem gerenciador de exibição, por exemplo Ubuntu netboot [amd64](http://archive.ubuntu.com/ubuntu/dists/focal/main/installer-amd64/current/legacy-images/netboot/mini.iso)

## Grava ISO em USB
* Os usuários de Windows/Mac podem gravar ISO híbrido em um dispositivo flash usando aplicativos especiais como Win32DiskImager ou Etcher.
* Os usuários do Linux podem instalar um ISO híbrido em um dispositivo flash usando o comando ‘dd’. Por exemplo:

```concha
sudo dd if=mini.iso of=/dev/sdb
```

## Instalação modo kiosk
* Faça login como root ou com permissões de root
* Baixe este instalador, torne-o executável e execute-o

  ```concha
  wget https://raw.githubusercontent.com/harrisonmattos/ubuntu-kiosk/main/install.sh; chmod +x install.sh; ./install.sh
  ```

Se você estiver instalando em um Raspberry Pi, altere o chromium para chromium-browser no script de instalação (na linha apt e no comando de inicialização)

## O que isso fará?
Ele criará um `quiosque` de usuário normal, instalará o software (verifique o script) e configurará as configurações (fará backup dos existentes) para que, na reinicialização, o usuário do quiosque faça login automaticamente e execute o chromium no modo quiosque com um URL. Também ocultará o mouse.

## Altere o URL
Altere o URL na parte inferior do script, onde diz https://quiosque.informatche.com.br

## É seguro?
Apesar de rodar como um usuário normal (e eu sugiro que você não deixe teclado e mouse por aí), haverá a possibilidade de plugin' em um mini teclado, abrindo um terminal e abrindo algumas coisas desagradáveis. Segurança é sua praia ;-)
