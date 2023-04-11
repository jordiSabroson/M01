#!/bin/bash
clear

#Comprovem usuari
if [ $(whoami) == "root" ]; then
	echo -e "Ets root."
else
	echo "No ets root."
	exit
fi

#Update
apt-get update >/dev/null 2>&1

#Registre del procés d'instal·lació
mkdir -p /script
touch /script/registre.txt

#Instal.lació paquet Apache2
if [ $(dpkg-query -W -f='${Status}' 'apache2' 2>/dev/null| grep -c "ok installed") -eq 0 ];then 
	echo "Apache2 no està instal.lat" >/script/registre.txt
	apt-get -y install apache2 >/dev/null 2>&1
	if [ $? -eq 0 ];then
		echo "Apache2 instal.lat correctament." >>/script/registre.txt
		echo "Apache2 instal.lat correctament."
	else
		echo "Apache2 instal.lat incorrectament."
	fi
else
	echo "Apache2 està instal.lat" >>/script/registre.txt
fi

#Instal.lació paquet mariadb-server
if [ $(dpkg-query -W -f='${Status}' 'mariadb-server' 2>/dev/null | grep -c "ok installed") -eq 0 ];then 
	echo "Mariadb-server no està instal.lat"
	apt-get -y install mariadb-server >/dev/null 2>&1
	if [ $? -eq 0 ];then
		echo "Mariadb-server instal.lat correctament." >>/script/registre.txt
		echo "Mariadb-server instal.lat correctament."
	else
		echo "Mariadb-server instal.lat incorrectament."
	fi
else
	echo "Mariadb-server està instal.lat" >>/script/registre.txt
fi

#Instal.lació paquet php
if [ $(dpkg-query -W -f='${Status}' 'php' 2>/dev/null| grep -c "ok installed") -eq 0 ];then 
	echo "PHP no està instal.lat"
	apt-get -y install php >/dev/null 2>&1
	if [ $? -eq 0 ];then
		echo "PHP instal.lat correctament." >>/script/registre.txt
		echo "PHP instal.lat correctament."
	else
		echo "PHP instal.lat incorrectament."
	fi
else
	echo "php està instal.lat" >>/script/registre.txt
fi

#Instal.lació paquet php-mysql
if [ $(dpkg-query -W -f='${Status}' 'php-mysql' 2>/dev/null| grep -c "ok installed") -eq 0 ];then 
	echo "php-mysql no està instal.lat"
	apt-get -y install php-mysql >/dev/null 2>&1
	if [ $? -eq 0 ];then
		echo "php-mysql instal.lat correctament." >>/script/registre.txt
		echo "php-mysql instal.lat correctament."
	else
		echo "php-mysql instal.lat incorrectament."
	fi
else
	echo "php-mysql està instal.lat" >>/script/registre.txt
fi

#Actualització del PHP 7.3 al 7.4
#Paquet lsb-release
echo "Actualització de PHP 7.3 a 7.4"
if [ $(dpkg-query -W -f='${Status}' 'lsb-release' 2>/dev/null| grep -c "ok installed") -eq 0 ];then
	echo "lsb-release no està instal·lat"
	apt -y install lsb-release >/dev/null 2>&1
        if [ $? -eq 0 ];then
                echo "lsb-release instal.lat correctament." >>/script/registre.txt
                echo "lsb-release instal.lat correctament."
        else
                echo "lsb-release instal.lat incorrectament."
        fi
else
        echo "lsb-release està instal.lat" >>/script/registre.txt
fi

#Paquet apt-transport-https
if [ $(dpkg-query -W -f='${Status}' 'apt-transport-https' 2>/dev/null| grep -c "ok installed") -eq 0 ];then
        echo "apt-transport-https no està instal·lat"
        apt -y install apt-transport-https >/dev/null 2>&1
        if [ $? -eq 0 ];then
                echo "apt-transport-https instal.lat correctament." >>/script/registre.txt
                echo "apt-transport-https instal.lat correctament."
        else
                echo "apt-transport-https instal.lat incorrectament."
        fi
else
        echo "apt-transport-https està instal.lat" >>/script/registre.txt
fi

#Paquet ca-certificates
if [ $(dpkg-query -W -f='${Status}' 'ca-certificates' 2>/dev/null| grep -c "ok installed") -eq 0 ];then
        echo "ca-certificates no està instal·lat"
        apt -y install ca-certificates >/dev/null 2>&1
        if [ $? -eq 0 ];then
                echo "ca-certificates instal.lat correctament." >>/script/registre.txt
                echo "ca-certificates instal.lat correctament."
        else
                echo "ca-certificates instal.lat incorrectament."
        fi
else
        echo "ca-certificates està instal.lat" >>/script/registre.txt
fi
wget -O /etc/apt/trusted.gpg.d/php.gpg https://packages.sury.org/php/apt.gpg >/dev/null 2>&1
echo "deb https://packages.sury.org/php/ $(lsb_release -sc) main" | tee /etc/apt/sources.list.d/php.list
apt update >/dev/null 2>&1
#Paquet php7.4
if [ $(dpkg-query -W -f='${Status}' 'php7.4' 2>/dev/null| grep -c "ok installed") -eq 0 ];then
        echo "php7.4 no està instal·lat"
        apt -y install php7.4 >/dev/null 2>&1
        if [ $? -eq 0 ];then
                echo "php7.4 instal.lat correctament." >>/script/registre.txt
                echo "php7.4 instal.lat correctament."
        else
                echo "php7.4 instal.lat incorrectament."
        fi
else
        echo "php7.4 està instal.lat" >>/script/registre.txt
fi
#Comprovem la versió del PHP

if [ "$(php --version | cut -c 1-7 | grep PHP)" == "PHP 7.4" ]; then
	echo "actualitzant PHP"
	a2dismod php7.3 2>/dev/null
	systemctl restart apache2 
	a2enmod php7.4 2>/dev/null
	systemctl restart apache2
        if [ $? -eq 0 ];then
                echo "versió del PHP actualitzada al PHP 7.4" >>/script/registre.txt
                echo "versió del PHP actualitzada al PHP 7.4"
        else
                echo "la versió no s'ha actualitzat correctament"
        fi
fi

echo "Instal·lació dels paquets obligatoris pel funcionament del GLPI"
#php7.4-curl
if [ $(dpkg-query -W -f='${Status}' 'php7.4-curl' 2>/dev/null| grep -c "ok installed") -eq 0 ];then
        echo "php7.4-curl no està instal·lat"
        apt -y install php7.4-curl >/dev/null 2>&1
        if [ $? -eq 0 ];then
                echo "php7.4-curl instal.lat correctament." >>/script/registre.txt
                echo "php7.4-curl instal.lat correctament."
        else
                echo "php7.4-curl instal.lat incorrectament."
        fi
else
        echo "php7.4-curl està instal.lat"
fi

#php7.4-fileinfo
if [ $(dpkg-query -W -f='${Status}' 'php7.4-fileinfo' 2>/dev/null| grep -c "ok installed") -eq 0 ];then 
	echo "php7.4-fileinfo no està instal.lat"
	apt-get -y install php7.4-fileinfo >/dev/null 2>&1
	if [ $? -eq 0 ];then
		echo "php7.4-fileinfo instal.lat correctament." >>/script/registre.txt
		echo "php7.4-fileinfo instal.lat correctament."
	else
		echo "php7.4-fileinfo instal.lat incorrectament."
	fi
else
	echo "php7.4-fileinfo està instal.lat" >>/script/registre.txt
fi

#php7.4-gd
if [ $(dpkg-query -W -f='${Status}' 'php7.4-gd' 2>/dev/null| grep -c "ok installed") -eq 0 ];then 
	echo "php7.4-gd no està instal.lat"
	apt-get -y install php7.4-gd >/dev/null 2>&1
	if [ $? -eq 0 ];then
		echo "php7.4-gd instal.lat correctament." >>/script/registre.txt
		echo "php7.4-gd instal.lat correctament."
	else
		echo "php7.4-gd instal.lat incorrectament."
	fi
else
	echo "php7.4-gd està instal.lat" >>/script/registre.txt
fi

#php7.4-json
if [ $(dpkg-query -W -f='${Status}' 'php7.4-json' 2>/dev/null| grep -c "ok installed") -eq 0 ];then 
	echo "php7.4-json no està instal.lat"
	apt-get -y install php7.4-json >/dev/null 2>&1
	if [ $? -eq 0 ];then
		echo "php7.4-json instal.lat correctament." >>/script/registre.txt
		echo "php7.4-json instal.lat correctament."
	else
		echo "php7.4-json instal.lat incorrectament."
	fi
else
	echo "php7.4-json està instal.lat" >>/script/registre.txt
fi

#php7.4-mbstring
if [ $(dpkg-query -W -f='${Status}' 'php7.4-mbstring' 2>/dev/null| grep -c "ok installed") -eq 0 ];then 
	echo "php7.4-mbstring no està instal.lat"
	apt-get -y install php7.4-mbstring >/dev/null 2>&1
	if [ $? -eq 0 ];then
		echo "php7.4-mbstring instal.lat correctament." >>/script/registre.txt
		echo "php7.4-mbstring instal.lat correctament."
	else
		echo "php7.4-mbstring instal.lat incorrectament."
	fi
else
	echo "php7.4-mbstring està instal.lat" >>/script/registre.txt
fi

#php7.4-mysqli
if [ $(dpkg-query -W -f='${Status}' 'php7.4-mysqli' 2>/dev/null| grep -c "ok installed") -eq 0 ];then 
	echo "php7.4-mysqli no està instal.lat"
	apt-get -y install php7.4-mysqli >/dev/null 2>&1
	if [ $? -eq 0 ];then
		echo "php7.4-mysqli instal.lat correctament." >>/script/registre.txt
		echo "php7.4-mysqli instal.lat correctament."
	else
		echo "php7.4-mysqli instal.lat incorrectament."
	fi
else
	echo "php7.4-mysqli està instal.lat" >>/script/registre.txt
fi

#php7.4-xml
if [ $(dpkg-query -W -f='${Status}' 'php7.4-xml' 2>/dev/null| grep -c "ok installed") -eq 0 ];then 
	echo "php7.4-xml no està instal.lat"
	apt-get -y install php7.4-xml >/dev/null 2>&1
	if [ $? -eq 0 ];then
		echo "php7.4-xml instal.lat correctament." >>/script/registre.txt
		echo "php7.4-xml instal.lat correctament."
	else
		echo "php7.4-xml instal.lat incorrectament."
	fi
else
	echo "php7.4-xml està instal.lat" >>/script/registre.txt
fi

#php7.4-intl
if [ $(dpkg-query -W -f='${Status}' 'php7.4-intl' 2>/dev/null| grep -c "ok installed") -eq 0 ];then 
	echo "php7.4-intl no està instal.lat"
	apt-get -y install php7.4-intl >/dev/null 2>&1
	if [ $? -eq 0 ];then
		echo "php7.4-intl instal.lat correctament." >>/script/registre.txt
		echo "php7.4-intl instal.lat correctament."
	else
		echo "php7.4-intl instal.lat incorrectament."
	fi
else
	echo "php7.4-intl està instal.lat" >>/script/registre.txt
fi
#Comprovem si la base de dades moodle existeix
dbname="glpi"
if [ -d "/var/lib/mysql/$dbname" ]; then
	echo "La base de dades existeix"
else
	echo "La base de dades no existeix"
	mysql -u root -e "CREATE DATABASE glpi;"
	mysql -u root -e "CREATE USER 'glpi'@'localhost' IDENTIFIED BY 'glpi';"
	mysql -u root -e "GRANT ALL PRIVILEGES ON glpi .* TO 'glpi'@'localhost';"
	mysql -u root -e "FLUSH PRIVILEGES;"
	mysql -u root -e "exit"
	echo "La base de dades glpi s'ha creat correctament"
fi

cd /opt/
if [ -d "glpi" ]; then
	echo "El fitxer ja està descarregat i descomprimit"
else
	echo "Descarregant el GLPI"
	wget https://github.com/glpi-project/glpi/releases/download/10.0.6/glpi-10.0.6.tgz%20 >/dev/null 2>&1
	tar zxvf 'glpi-10.0.6.tgz ' >/dev/null 2>&1
	rm /var/www/html/index.html
	mv glpi/* /var/www/html
	chmod -R 755 /var/www/
	chown -R www-data:www-data /var/www/
fi
systemctl restart apache2
echo "SQL server: localhost"
echo "User: glpi"
echo "Password: glpi"
#Cal fer control d'errors a totes les setències
