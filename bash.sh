#!/bin/bash
clear
#Colors
verd='\e[38;5;46m'
vermell='\e[38;5;197m'
blau='\e[38;5;27m'
final='\e[38;5;0m'
#Comprovem usuari
if [ $(whoami) == "root" ]; then
	echo -e -e "${verd}Ets root.${final}"
else
	echo -e "${vermell}No ets root.${final}"
	exit
fi

#Update
apt-get update >/dev/null 2>&1

#Registre del procés d'instal·lació
mkdir -p /script
if [ $? -eq 0 ]; then
	touch /script/registre.txt
	if [ $? -eq 0 ]; then
		echo -e "${blau}S'ha creat un registre de la instal·lació al directori /script/registre.txt${final}"
		echo -e "${blau}Registre de la instal·lació del GLPI:${final}" >>/script/registre.txt
	else
		echo -e "${vermell}No s'ha pogut crear el registre de la instal·lació${final}"
	fi
else
	echo -e "${vermell}No s'ha pogut crear el registre de la instal·lació${final}"
fi 

#Instal.lació paquet Apache2
if [ $(dpkg-query -W -f='${Status}' 'apache2' 2>/dev/null| grep -c "ok installed") -eq 0 ];then 
	echo -e "${vermell}Apache2 no està instal.lat${final}" >>/script/registre.txt
	echo -e "${vermell}Apache2 no està instal.lat${final}"
	apt-get -y install apache2 >/dev/null 2>&1
	if [ $? -eq 0 ];then
		echo -e "${verd}Apache2 instal.lat correctament.${final}" >>/script/registre.txt
		echo -e "${verd}Apache2 instal.lat correctament.${final}"
	else
		echo -e "${vermell}Apache2 instal.lat incorrectament.${final}" >>/script/registre.txt
		echo -e "${vermell}Apache2 instal.lat incorrectament.${final}"
	fi
else
	echo -e "${verd}Apache2 està instal.lat${final}" >>/script/registre.txt
	echo -e "${verd}Apache2 està instal.lat${final}"
fi

#Instal.lació paquet mariadb-server
if [ $(dpkg-query -W -f='${Status}' 'mariadb-server' 2>/dev/null | grep -c "ok installed") -eq 0 ];then 
	echo -e "${vermell}Mariadb-server no està instal.lat${final}" >>/script/registre.txt
	echo -e "${vermell}Mariadb-server no està instal.lat${final}"
	apt-get -y install mariadb-server >/dev/null 2>&1
	if [ $? -eq 0 ];then
		echo -e "${verd}Mariadb-server instal.lat correctament.${final}" >>/script/registre.txt
		echo -e "${verd}Mariadb-server instal.lat correctament.${final}"
	else
		echo -e "${vermell}Mariadb-server instal.lat incorrectament.${final}" >>/script/registre.txt
		echo -e "${vermell}Mariadb-server instal.lat incorrectament.${final}"
	fi
else
	echo -e "${verd}Mariadb-server està instal.lat${final}" >>/script/registre.txt
	echo -e "${verd}Mariadb-server està instal.lat${final}"
fi

#Instal.lació paquet php
if [ $(dpkg-query -W -f='${Status}' 'php' 2>/dev/null| grep -c "ok installed") -eq 0 ];then 
	echo -e "${vermell}PHP no està instal.lat${final}" >>/script/registre.txt
	echo -e "${vermell}PHP no està instal.lat${final}"
	apt-get -y install php >/dev/null 2>&1
	if [ $? -eq 0 ];then
		echo -e "${verd}PHP instal.lat correctament.${final}" >>/script/registre.txt
		echo -e "${verd}PHP instal.lat correctament.${final}"
	else
		echo -e "${vermell}PHP instal.lat incorrectament.${final}" >>/script/registre.txt
		echo -e "${vermell}PHP instal.lat incorrectament.${final}"
	fi
else
	echo -e "${verd}php està instal.lat${final}" >>/script/registre.txt
	echo -e "${verd}php està instal.lat${final}"
fi

#Instal.lació paquet php-mysql
if [ $(dpkg-query -W -f='${Status}' 'php-mysql' 2>/dev/null| grep -c "ok installed") -eq 0 ];then 
	echo -e "${vermell}php-mysql no està instal.lat${final}" >>/script/registre.txt
	echo -e "${vermell}php-mysql no està instal.lat${final}"
	apt-get -y install php-mysql >/dev/null 2>&1
	if [ $? -eq 0 ];then
		echo -e "${verd}php-mysql instal.lat correctament.${final}" >>/script/registre.txt
		echo -e "${verd}php-mysql instal.lat correctament.${final}"
	else
		echo -e "${vermell}php-mysql instal.lat incorrectament.${final}" >>/script/registre.txt
		echo -e "${vermell}php-mysql instal.lat incorrectament.${final}"
	fi
else
	echo -e "${verd}php-mysql està instal.lat${final}" >>/script/registre.txt
	echo -e "${verd}php-mysql està instal.lat${final}"
fi

#Actualització del PHP 7.3 al 7.4
#Paquet lsb-release
echo -e "${blau}Actualització de PHP 7.3 a 7.4${final}"
if [ $(dpkg-query -W -f='${Status}' 'lsb-release' 2>/dev/null| grep -c "ok installed") -eq 0 ];then
	echo -e "${vermell}lsb-release no està instal·lat${final}" >>/script/registre.txt
	echo -e "${vermell}lsb-release no està instal·lat${final}"
	apt -y install lsb-release >/dev/null 2>&1
        if [ $? -eq 0 ];then
                echo -e "${verd}lsb-release instal.lat correctament.${final}" >>/script/registre.txt
                echo -e "${verd}lsb-release instal.lat correctament.${final}"
        else
                echo -e "${vermell}lsb-release instal.lat incorrectament.${final}" >>/script/registre.txt
				echo -e "${vermell}lsb-release instal.lat incorrectament.${final}"
        fi
else
        echo -e "${verd}lsb-release està instal.lat${final}" >>/script/registre.txt
		echo -e "${verd}lsb-release està instal.lat${final}"
fi

#Paquet apt-transport-https
if [ $(dpkg-query -W -f='${Status}' 'apt-transport-https' 2>/dev/null| grep -c "ok installed") -eq 0 ];then
        echo -e "${vermell}apt-transport-https no està instal·lat${final}" >>/script/registre.txt
		echo -e "${vermell}apt-transport-https no està instal·lat${final}"
        apt -y install apt-transport-https >/dev/null 2>&1
        if [ $? -eq 0 ];then
                echo -e "${verd}apt-transport-https instal.lat correctament.${final}" >>/script/registre.txt
                echo -e "${verd}apt-transport-https instal.lat correctament.${final}"
        else
                echo -e "${vermell}apt-transport-https instal.lat incorrectament.${final}" >>/script/registre.txt
				echo -e "${vermell}apt-transport-https instal.lat incorrectament.${final}"
        fi
else
        echo -e "${verd}apt-transport-https està instal.lat${final}" >>/script/registre.txt
		echo -e "${verd}apt-transport-https està instal.lat${final}"
fi

#Paquet ca-certificates
if [ $(dpkg-query -W -f='${Status}' 'ca-certificates' 2>/dev/null| grep -c "ok installed") -eq 0 ];then
        echo -e "${vermell}ca-certificates no està instal·lat${final}" >>/script/registre.txt
		echo -e "${vermell}ca-certificates no està instal·lat${final}"
        apt -y install ca-certificates >/dev/null 2>&1
        if [ $? -eq 0 ];then
                echo -e "${verd}ca-certificates instal.lat correctament.${final}" >>/script/registre.txt
                echo -e "${verd}ca-certificates instal.lat correctament.${final}"
        else
                echo -e "${vermell}ca-certificates instal.lat incorrectament.${final}" >>/script/registre.txt
				echo -e "${vermell}ca-certificates instal.lat incorrectament.${final}"
        fi
else
        echo -e "${verd}ca-certificates està instal.lat${final}" >>/script/registre.txt
		echo -e "${verd}ca-certificates està instal.lat${final}"
fi

wget -O /etc/apt/trusted.gpg.d/php.gpg https://packages.sury.org/php/apt.gpg >/dev/null 2>&1
echo -e "deb https://packages.sury.org/php/ $(lsb_release -sc) main" | tee /etc/apt/sources.list.d/php.list >/dev/null 2>&1
apt update >/dev/null 2>&1

#Paquet php7.4
if [ $(dpkg-query -W -f='${Status}' 'php7.4' 2>/dev/null| grep -c "ok installed") -eq 0 ];then
        echo -e "${vermell}php7.4 no està instal·lat${final}" >>/script/registre.txt
		echo -e "${vermell}php7.4 no està instal·lat${final}"
        apt -y install php7.4 >/dev/null 2>&1
        if [ $? -eq 0 ];then
                echo -e "${verd}php7.4 instal.lat correctament.${final}" >>/script/registre.txt
                echo -e "${verd}php7.4 instal.lat correctament.${final}"
        else
                echo -e "${vermell}php7.4 instal.lat incorrectament.${final}" >>/script/registre.txt
				echo -e "${vermell}php7.4 instal.lat incorrectament.${final}"
        fi
else
        echo -e "${verd}php7.4 està instal.lat${final}" >>/script/registre.txt
		echo -e "${verd}php7.4 està instal.lat${final}"
fi

#Comprovem la versió del PHP

if [ "$(php --version | cut -c 1-7 | grep PHP)" == "PHP 7.4" ]; then
	echo -e "${blau}Actualitzant PHP...${final}" >>/script/registre.txt
	echo -e "${blau}Actualitzant PHP...${final}"
	a2dismod php7.3 >/dev/null 2>&1
	systemctl restart apache2 
	a2enmod php7.4 >/dev/null 2>&1
	systemctl restart apache2
        if [ $? -eq 0 ];then
                echo -e "${verd}versió del PHP actualitzada al PHP 7.4${final}" >>/script/registre.txt
                echo -e "${verd}versió del PHP actualitzada al PHP 7.4${final}"
        else
                echo -e "${vermell}la versió no s'ha actualitzat correctament${final}" >>/script/registre.txt
				echo -e "${vermell}la versió no s'ha actualitzat correctament${final}"
        fi
fi

echo -e "${blau}Instal·lació dels paquets obligatoris pel funcionament del GLPI${final}" >>/script/registre.txt
echo -e "${blau}Instal·lació dels paquets obligatoris pel funcionament del GLPI${final}"
#php7.4-curl
if [ $(dpkg-query -W -f='${Status}' 'php7.4-curl' 2>/dev/null| grep -c "ok installed") -eq 0 ];then
        echo -e "${vermell}php7.4-curl no està instal·lat${final}" >>/script/registre.txt
		echo -e "${vermell}php7.4-curl no està instal·lat${final}"
        apt -y install php7.4-curl >/dev/null 2>&1
        if [ $? -eq 0 ];then
                echo -e "${verd}php7.4-curl instal.lat correctament.${final}" >>/script/registre.txt
                echo -e "${verd}php7.4-curl instal.lat correctament.${final}"
        else
                echo -e "${vermell}php7.4-curl instal.lat incorrectament.${final}" >>/script/registre.txt
				echo -e "${vermell}php7.4-curl instal.lat incorrectament.${final}"
        fi
else
        echo -e "${verd}php7.4-curl està instal.lat${final}" >>/script/registre.txt
		echo -e "${verd}php7.4-curl està instal.lat${final}"
fi

#php7.4-fileinfo
if [ $(dpkg-query -W -f='${Status}' 'php7.4-fileinfo' 2>/dev/null| grep -c "ok installed") -eq 0 ];then 
	echo -e "${vermell}php7.4-fileinfo no està instal.lat${final}" >>/script/registre.txt
	echo -e "${vermell}php7.4-fileinfo no està instal.lat${final}"
	apt-get -y install php7.4-fileinfo >/dev/null 2>&1
	if [ $? -eq 0 ];then
		echo -e "${verd}php7.4-fileinfo instal.lat correctament.${final}" >>/script/registre.txt
		echo -e "${verd}php7.4-fileinfo instal.lat correctament.${final}"
	else
		echo -e "${vermell}php7.4-fileinfo instal.lat incorrectament.${final}" >>/script/registre.txt
		echo -e "${vermell}php7.4-fileinfo instal.lat incorrectament.${final}"
	fi
else
	echo -e "${verd}php7.4-fileinfo està instal.lat${final}" >>/script/registre.txt
	echo -e "${verd}php7.4-fileinfo està instal.lat${final}"
fi

#php7.4-gd
if [ $(dpkg-query -W -f='${Status}' 'php7.4-gd' 2>/dev/null| grep -c "ok installed") -eq 0 ];then 
	echo -e "${vermell}php7.4-gd no està instal.lat${final}" >>/script/registre.txt
	echo -e "${vermell}php7.4-gd no està instal.lat${final}"
	apt-get -y install php7.4-gd >/dev/null 2>&1
	if [ $? -eq 0 ];then
		echo -e "${verd}php7.4-gd instal.lat correctament.${final}" >>/script/registre.txt
		echo -e "${verd}php7.4-gd instal.lat correctament.${final}"
	else
		echo -e "${vermell}php7.4-gd instal.lat incorrectament.${final}" >>/script/registre.txt
		echo -e "${vermell}php7.4-gd instal.lat incorrectament.${final}"
	fi
else
	echo -e "${verd}php7.4-gd està instal.lat${final}" >>/script/registre.txt
	echo -e "${verd}php7.4-gd està instal.lat${final}"
fi

#php7.4-json
if [ $(dpkg-query -W -f='${Status}' 'php7.4-json' 2>/dev/null| grep -c "ok installed") -eq 0 ];then 
	echo -e "${vermell}php7.4-json no està instal.lat${final}" >>/script/registre.txt
	echo -e "${vermell}php7.4-json no està instal.lat${final}"
	apt-get -y install php7.4-json >/dev/null 2>&1
	if [ $? -eq 0 ];then
		echo -e "${verd}php7.4-json instal.lat correctament.${final}" >>/script/registre.txt
		echo -e "${verd}php7.4-json instal.lat correctament.${final}"
	else
		echo -e "${vermell}php7.4-json instal.lat incorrectament.${final}" >>/script/registre.txt 
		echo -e "${vermell}php7.4-json instal.lat incorrectament.${final}"
	fi
else
	echo -e "${verd}php7.4-json està instal.lat${final}" >>/script/registre.txt
	echo -e "${verd}php7.4-json està instal.lat${final}"
fi

#php7.4-mbstring
if [ $(dpkg-query -W -f='${Status}' 'php7.4-mbstring' 2>/dev/null| grep -c "ok installed") -eq 0 ];then 
	echo -e "${vermell}php7.4-mbstring no està instal.lat${final}" >>/script/registre.txt
	echo -e "${vermell}php7.4-mbstring no està instal.lat${final}"
	apt-get -y install php7.4-mbstring >/dev/null 2>&1
	if [ $? -eq 0 ];then
		echo -e "${verd}php7.4-mbstring instal.lat correctament.${final}" >>/script/registre.txt
		echo -e "${verd}php7.4-mbstring instal.lat correctament.${final}"
	else
		echo -e "${vermell}php7.4-mbstring instal.lat incorrectament.${final}" >>/script/registre.txt
		echo -e "${vermell}php7.4-mbstring instal.lat incorrectament.${final}"
	fi
else
	echo -e "${verd}php7.4-mbstring està instal.lat${final}" >>/script/registre.txt
	echo -e "${verd}php7.4-mbstring està instal.lat${final}"
fi

#php7.4-mysqli
if [ $(dpkg-query -W -f='${Status}' 'php7.4-mysqli' 2>/dev/null| grep -c "ok installed") -eq 0 ];then 
	echo -e "${vermell}php7.4-mysqli no està instal.lat${final}" >>/script/registre.txt
	echo -e "${vermell}php7.4-mysqli no està instal.lat${final}"
	apt-get -y install php7.4-mysqli >/dev/null 2>&1
	if [ $? -eq 0 ];then
		echo -e "${verd}php7.4-mysqli instal.lat correctament.${final}" >>/script/registre.txt
		echo -e "${verd}php7.4-mysqli instal.lat correctament.${final}"
	else
		echo -e "${vermell}php7.4-mysqli instal.lat incorrectament.${final}" >>/script/registre.txt
		echo -e "${vermell}php7.4-mysqli instal.lat incorrectament.${final}"
	fi
else
	echo -e "${verd}php7.4-mysqli està instal.lat${final}" >>/script/registre.txt
	echo -e "${verd}php7.4-mysqli està instal.lat${final}"
fi

#php7.4-xml
if [ $(dpkg-query -W -f='${Status}' 'php7.4-xml' 2>/dev/null| grep -c "ok installed") -eq 0 ];then 
	echo -e "${vermell}php7.4-xml no està instal.lat${final}" >>/script/registre.txt
	echo -e "${vermell}php7.4-xml no està instal.lat${final}"
	apt-get -y install php7.4-xml >/dev/null 2>&1
	if [ $? -eq 0 ];then
		echo -e "${verd}php7.4-xml instal.lat correctament.${final}" >>/script/registre.txt
		echo -e "${verd}php7.4-xml instal.lat correctament.${final}"
	else
		echo -e "${vermell}php7.4-xml instal.lat incorrectament.${final}" >>/script/registre.txt
		echo -e "${vermell}php7.4-xml instal.lat incorrectament.${final}"
	fi
else
	echo -e "${verd}php7.4-xml està instal.lat${final}" >>/script/registre.txt
	echo -e "${verd}php7.4-xml està instal.lat${final}"
fi

#php7.4-intl
if [ $(dpkg-query -W -f='${Status}' 'php7.4-intl' 2>/dev/null| grep -c "ok installed") -eq 0 ];then 
	echo -e "${vermell}php7.4-intl no està instal.lat${final}" >>/script/registre.txt
	echo -e "${vermell}php7.4-intl no està instal.lat${final}"
	apt-get -y install php7.4-intl >/dev/null 2>&1
	if [ $? -eq 0 ];then
		echo -e "${verd}php7.4-intl instal.lat correctament.${final}" >>/script/registre.txt
		echo -e "${verd}php7.4-intl instal.lat correctament.${final}"
	else
		echo -e "${vermell}php7.4-intl instal.lat incorrectament.${final}" >>/script/registre.txt
		echo -e "${vermell}php7.4-intl instal.lat incorrectament.${final}"
	fi
else
	echo -e "${verd}php7.4-intl està instal.lat${final}" >>/script/registre.txt
	echo -e "${verd}php7.4-intl està instal.lat${final}"
fi
#Comprovem si la base de dades moodle existeix
dbname="glpi"
if [ -d "/var/lib/mysql/$dbname" ]; then
	echo -e "${verd}La base de dades existeix${final}" >>/script/registre.txt
	echo -e "${verd}La base de dades existeix${final}"
else
	echo -e "${vermell}La base de dades no existeix${final}" >>/script/registre.txt
	echo -e "${vermell}La base de dades no existeix${final}"
	mysql -u root -e "CREATE DATABASE glpi;"
	mysql -u root -e "CREATE USER 'glpi'@'localhost' IDENTIFIED BY 'glpi';"
	mysql -u root -e "GRANT ALL PRIVILEGES ON glpi .* TO 'glpi'@'localhost';"
	mysql -u root -e "FLUSH PRIVILEGES;"
	mysql -u root -e "exit"
	echo -e "${verd}La base de dades glpi s'ha creat correctament${final}" >>/script/registre.txt
	echo -e "${verd}La base de dades glpi s'ha creat correctament${final}"
fi

cd /opt/
if [ -d "glpi" ]; then
	echo -e "${verd}El fitxer ja està descarregat i descomprimit${final}" >>/script/registre.txt
	echo -e "${verd}El fitxer ja està descarregat i descomprimit${final}"
else
	echo -e "${blau}Descarregant el GLPI${final}" >>/script/registre.txt
	echo -e "${blau}Descarregant el GLPI${final}"
	wget https://github.com/glpi-project/glpi/releases/download/10.0.6/glpi-10.0.6.tgz%20 >/dev/null 2>&1
	tar zxvf 'glpi-10.0.6.tgz ' >/dev/null 2>&1
	rm /var/www/html/index.html
	mv glpi/* /var/www/html
	chmod -R 755 /var/www/
	chown -R www-data:www-data /var/www/
fi
systemctl restart apache2
echo -e "${blau}SQL server: localhost${final}"
echo -e "${blau}User: glpi${final}"
echo -e "${blau}Password: glpi${final}"
#Cal fer control d'errors a totes les setències
