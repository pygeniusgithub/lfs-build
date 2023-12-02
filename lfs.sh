#!/bin/bash

# Установка основных зависимостей
sudo apt-get update
sudo apt-get install -y build-essential

# Создание каталога для сборки LFS
sudo mkdir /mnt/lfs
sudo chmod a+wt /mnt/lfs

# Добавление пользователя для сборки
sudo groupadd lfs
sudo useradd -s /bin/bash -g lfs -m -k /dev/null lfs
sudo passwd lfs

# Настройка окружения пользователя lfs
sudo chown -v lfs /mnt/lfs

# Переключение пользователя
su - lfs

# Настройка переменных окружения
cat > ~/.bash_profile << "EOF"
exec env -i HOME=$HOME TERM=$TERM PS1='\u:\w\$ ' /bin/bash
EOF

cat > ~/.bashrc << "EOF"
set +h
umask 022
LFS=/mnt/lfs
LC_ALL=POSIX
LFS_TGT=$(uname -m)-lfs-linux-gnu
PATH=/tools/bin:/bin:/usr/bin
export LFS LC_ALL LFS_TGT PATH
EOF

source ~/.bash_profile

# Клонирование репозитория LFS
git clone http://www.linuxfromscratch.org/lfs/view/stable/lfs-bootscripts.git
cd lfs-bootscripts
make install

# Возвращение в каталог исходного кода
cd $LFS/sources

# Загрузка и распаковка пакетов
wget http://www.linuxfromscratch.org/lfs/view/stable/wget-list
wget --input-file=wget-list --continue --directory-prefix=$LFS/sources

# Распаковка и установка пакетов
chmod -Rv a+wt $LFS/sources
tar -xf $LFS/sources/*.tar.*
cd $LFS/sources/*/
./configure --prefix=/tools
make
make install

# Продолжение сборки LFS, установка пакетов по мере необходимости

# Пример: установка ядра
cd $LFS/sources/linux-*
make mrproper
make menuconfig
make
make install

# Пример: установка GRUB
cd $LFS/sources/grub-*
./configure --prefix=/usr
make
make install

# Пример: установка Xorg
cd $LFS/sources/xorg-*
./configure --prefix=/usr
make
make install

# Пример: установка Openbox
cd $LFS/sources/openbox-*
./configure --prefix=/usr
make
make install

# Создание каталога для конфигурационных файлов Openbox
mkdir -p $HOME/.config/openbox

# Занесение базовой конфигурации для Openbox
cat > $HOME/.config/openbox/rc.xml << "EOF"
<?xml version="1.0"?>
<openbox_config xmlns="http://openbox.org/3.4/rc" xmlns:xi="http://www.w3.org/2001/XInclude">
  <resistance>
    <distance name="border">3</distance>
    <distance name="snap">5</distance>
    <edge name="top">state=maximized</edge>
    <edge name="bottom">state=maximized</edge>
    <edge name="left">state=maximized</edge>
    <edge name="right">state=maximized</edge>
  </resistance>
  <theme>
    <name>Clearlooks</name>
    <titleLayout>LRHC</titleLayout>
    <font place="ActiveWindow">
      <name>Droid Sans</name>
      <size>8</size>
      <weight>Bold</weight>
      <slant>Oblique</slant>
    </font>
  </theme>
  <!-- Другие настройки Openbox -->
</openbox_config>
EOF

# Пример: установка Firefox
cd $LFS/sources/firefox-*
./configure --prefix=/usr
make
make install

# Пример: установка LibreOffice
cd $LFS/sources/libreoffice-*
./configure --prefix=/usr
make
make install

# Решение распространенных проблем при компиляции
# Пример: установка pkg-config
cd $LFS/sources/pkg-config-*
./configure --prefix=/usr
make
make install

# Пример: решение проблемы с библиотеками, добавление символических ссылок
ln -s /usr/lib/libncursesw.so.6 /usr/lib/libncurses.so

# Пример: решение проблемы с библиотекой libtool
cd $LFS/sources/libtool-*
./configure --prefix=/usr
make
make install

# Завершение сборки и настройки системы
echo "Сборка LFS завершена. Можете продолжить с настройкой вашей системы."

# Выйти из сеанса пользователя lfs
exit
