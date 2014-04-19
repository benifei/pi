#!/bin/bash
# -*- Mode: sh; coding: utf-8; indent-tabs-mode: nil; tab-width: 4 -*-
#
# Auteur :
# Benjamin Benifei
# 
# Description:
# « Script de post-installation du système d'exploitation Ubuntu (14.04) »
# Le but est de faciliter l'utilisation d'un système nouvellement installé.
#
# Basé sur le travail de Sam Hewitt <hewittsamuel@gmail.com>, distribué sous
# licence GNU GPL à l'adresse <https://github.com/snwh/ubuntu-post-install>
# 
# Licence :
# This script is free software; you can redistribute it and/or modify it under
# the terms of the GNU General Public License as published by the Free Software
# Foundation; version 3.
#
# This script is distributed in the hope that it will be useful, but WITHOUT
# ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS
# FOR A PARTICULAR PURPOSE.  See the GNU General Public License for more
# details.
#
# You should have received a copy of the GNU General Public License along with
# this program; if not, see <https://www.gnu.org/licenses/gpl-3.0.txt>
#
#


echo ''
echo '#-------------------------------------------#'
echo '#     Personnalisation -- Ubuntu 14.04      #'
echo '#-------------------------------------------#'

#----- Fonctions -----#

# Fonction 1 : Mise à jour du système
function sysupgrade {
echo ''
read -p 'Mettre le système à jour ? (O)ui, (N)on : ' REPLY
case $REPLY in
# Réponse positive
[Oo]* )
    # Mise à jour des informations des dépôts 
    echo 'Mise à jour des informations des dépôts...'
    echo 'Root requis :'
    sudo apt-get update
    # Installation des mises à jour avec gestion des dépendances
    echo 'Installation des mises à jour...'
    sudo apt-get dist-upgrade -y
    echo 'Fait.'
    main
    ;;
# Réponse négative
[Nn]* )
    clear && main
    ;;
# Erreur
* )
    clear && echo 'Désolé, réessayez.'
    sysupgrade
    ;;
esac
}

# Fonction 2 : Installer les paquets recommandés
function favourites {
# Liste des paquets recommandés
echo ''
echo 'Installation des paquets sélectionnés...'
echo ''
echo 'Liste des paquets à installer :
aptitude
compizconfig-settings-manager
dconf-tools
enigmail
filezilla
firefox-locale-fr
flashplugin-installer
gimp
gimp-help-fr
gksu
gparted
hunspell-fr
hyphen-fr
language-pack-fr
language-pack-fr-base
language-pack-gnome-fr
language-pack-gnome-fr-base
libreoffice
libreoffice-help-fr
libreoffice-l10n-fr
mythes-fr
nano
p7zip-full
guake
rar
ssh
sublime-text-3
synaptic
thunderbird
thunderbird-locale-fr
ubuntu-restricted-extras
unity-tweak-tool
vlc
wfrench
wine
xchat'
echo ''
read -p 'Continuer ? (O)ui, (N)on : ' REPLY
case $REPLY in
# Réponse positive
[Oo]* ) 
    # Mise à jour des informations des dépôts et installation des paquets recommandés
    echo 'Ajout de dépôts'
    sudo add-apt-repository ppa:webupd8team/sublime-text-3
    echo 'Installation des applications...'
    echo 'Root requis :'
    sudo apt-get update
    sudo apt-get install -y --no-install-recommends aptitude compizconfig-settings-manager dconf-tools enigmail flashplugin-installer filezilla firefox-locale-fr gimp gimp-help-fr gksu gparted hunspell-fr hyphen-fr language-pack-fr language-pack-fr-base language-pack-gnome-fr language-pack-gnome-fr-base libreoffice libreoffice-help-fr libreoffice-l10n-fr mythes-fr nano p7zip-full guake rar ssh sublime-text-installer synaptic thunderbird thunderbird-locale-fr ubuntu-restricted-extras unity-tweak-tool vlc wfrench xchat wine
    echo 'Fait.'
    main
    ;;
# Réponse négative
[Nn]* )
    clear && main
    ;;
# Erreur
* )
    clear && echo 'Désolé, réessayez.'
    favourites
    ;;
esac
}

# Fonction 3 : Installation des outils de chiffrement
function crypto {
echo ''
echo '1. Installer Truecrypt ?'
echo '2. Installer AxCrypt ?'
echo 'r. Retour.'
echo ''
read -p 'Que souhaitez-vous faire ? (Entrez votre choix) : ' REPLY
case $REPLY in
# Installation de Truecrypt
1)
    echo 'Procédure d’installation de Truecrypt...'
    echo ''
    echo 'L’opération suivante va utiliser wget pour télécharger Truecrypt depuis l’internet.'
    read -p 'Continuer ? (O)ui, (N)on : ' REPLY
    case $REPLY in
    # Réponse positive
    [Oo]* )
        # Téléchargement de Truecrypt avec wget 
        echo 'Téléchargement de Truecrypt...'
        wget http://www.truecrypt.org/download/truecrypt-7.1a-linux-x86.tar.gz
        read -p "Appuyez sur une touche pour continuer... " -n1 -s
        # Installation de Truecrypt
        echo ''
        echo 'Installation de Truecrypt...'
        echo 'Root requis :'
        tar -xzf ~/truecrypt-7.1a-linux-x86.tar.gz
        sh truecrypt-7.1a-setup-x86
        echo 'Fait.'
        main
        ;;
    # Réponse négative
    [Nn]* )
        clear && system
        ;;
    # Erreur
    * )
        clear && echo 'Désolé, réessayez.'
        system
        ;;
    esac
    ;;
# Installation d'AxCrypt
2)
    echo 'Procédure d’installation de AxCrypt...'
    echo ''
    # Wine (émulateur de programmes Microsoft Windows) est requis
    echo 'Installation des logiciels prérequis par AxCrypt (Wine)...'
    echo 'Root requis :'
    sudo apt-get install -y --no-install-recommends wine
    echo 'Fait.'
    echo ''
    echo 'L’opération suivante va utiliser wget pour télécharger AxCrypt depuis l’internet.'
    read -p 'Continuer ? (O)ui, (N)on : ' REPLY
    case $REPLY in
    # Réponse positive
    [Oo]* )
        # Téléchargement de AxCrypt2Go.exe avec wget
        echo 'Téléchargement de AxCrypt...'
        wget -P ~/.wine/drive_c/ http://www.axantum.com/Download/AxCrypt2Go.exe
        read -p "Appuyez sur une touche pour continuer... " -n1 -s
        echo ''
        # Intégration de AxCrypt dans la liste des programmes
        echo 'Installation de AxCrypt dans la liste des application du Dash...'
        echo 'Root requis : '
        sudo bash -c 'echo "#!/usr/bin/env xdg-open" > /usr/share/applications/AxCrypt.desktop'
        sudo bash -c 'echo "[Desktop Entry]" >> /usr/share/applications/AxCrypt.desktop'
		sudo bash -c 'echo "Version=1.0" >> /usr/share/applications/AxCrypt.desktop'
		sudo bash -c 'echo "Exec=wine \"C:/AxCrypt2Go.exe\"" >> /usr/share/applications/AxCrypt.desktop'
		sudo bash -c 'echo "Icon=wine" >> /usr/share/applications/AxCrypt.desktop'
		sudo bash -c 'echo "Terminal=false" >> /usr/share/applications/AxCrypt.desktop'
		sudo bash -c 'echo "Type=Application" >> /usr/share/applications/AxCrypt.desktop'
		sudo bash -c 'echo "Categories=Wine;" >> /usr/share/applications/AxCrypt.desktop'
        sudo bash -c 'echo "Name=AxCrypt" >> /usr/share/applications/AxCrypt.desktop'
		sudo bash -c 'echo "StartupNotify=true" >> /usr/share/applications/AxCrypt.desktop'
        echo 'Fait.'
        main
        ;;
    # Réponse négative
    [Nn]* )
        clear && system
        ;;
    # Erreur
    * )
        clear && echo 'Désolé, réessayez.'
        system
        ;;
    esac
    ;;
# Retour
[Rr]*) 
    clear && main;;
# Réponse invalide
* ) 
    clear && echo 'Choix invalide, réessayez.' && development;;
esac
}

# Fonction 4 : Nettoyage du système
function cleanup {
echo ''
echo '1. Supprimer les paquets préinstallés inutiles ?'
echo '2. Supprimer les anciens noyaux ?'
echo '3. Supprimer les paquets orphelins ?'
echo '4. Supprimer les fichiers de configuration restants ?'
echo '5. Nettoyer le cache des paquets ?'
echo 'r. Retour ?'
echo ''
read -p 'Que souhaitez-vous faire ? (Entrez votre choix) : ' REPLY
case $REPLY in
# Suppression des paquets inutiles et des outils publicitaires
1)
    echo 'Suppression des paquets préinstallés inutiles...'
    echo 'Root requis :'
    sudo apt-get purge landscape-client-ui-install aisleriot gnome-mahjongg gnome-mines gnome-sudoku gnomine transmission ubuntuone-client ubuntuone-control-panel ubuntuone-control-panel-qt unity-lens-shopping unity-scope-gdrive unity-scope-musicstores python-ubuntuone-* unity-webapps-common
    echo 'Suppression des outils commerciaux du Dash d’Unity...'
    gsettings set com.canonical.Unity.Lenses disabled-scopes "['more_suggestions-amazon.scope', 'more_suggestions-u1ms.scope', 'more_suggestions-populartracks.scope', 'music-musicstore.scope', 'more_suggestions-ebay.scope', 'more_suggestions-ubuntushop.scope', 'more_suggestions-skimlinks.scope']"
    echo 'Désactivation des rapports d’erreur'
    sudo service apport stop ; sudo sed -ibak -e s/^enabled\=1$/enabled\=0/ /etc/default/apport ; sudo mv /etc/default/apportbak ~
    echo 'Activation de la recherche récursive dans Nautilus'
    gsettings set org.gnome.nautilus.preferences enable-interactive-search false
    echo 'Fait.'
    cleanup
    ;;
# Suppression des noyaux non-utilisés
2)
    echo 'Suppression des anciens noyaux...'
    echo 'Root requis :'
    sudo dpkg -l 'linux-*' | sed '/^ii/!d;/'"$(uname -r | sed "s/\(.*\)-\([^0-9]\+\)/\1/")"'/d;s/^[^ ]* [^ ]* \([^ ]*\).*/\1/;/[0-9]/!d' | grep -v linux-libc-dev | xargs sudo apt-get -y purge
    echo 'Fait.'
    cleanup
    ;;
# Suppression des paquets orphelins
3)
    echo 'Suppression des paquets orphelins...'
    echo 'Root requis :'
    sudo apt-get autoremove -y
    echo 'Fait.'
    cleanup
    ;;
# Suppression des fichiers de configuration restants
4)
    echo 'Suppression des fichiers de configuration restants...'
    echo 'Root requis :'
    sudo dpkg --purge $(COLUMNS=200 dpkg -l | grep '^rc' | tr -s ' ' | cut -d ' ' -f 2)
    echo 'Fait.'
    cleanup
    ;;
# Nettoyage des fichiers temporaires du gestionnaire de paquets
5)
    echo 'Nettoyage du cache des paquets...'
    echo 'Root requis :'
    sudo apt-get clean
    echo 'Fait.'
    cleanup
    ;;
# Retour
[Rr]*) 
    clear && main;;
# Réponse invalide
* ) 
    clear && echo 'Choix invalide, réessayez.' && cleanup;;
esac
}

# Quitter
function quit {
read -p "Êtes-vous sûr de vouloir quitter ? (O)ui, (N)on : " REPLY
case $REPLY in
    [Oo]* ) exit 99;;
    [Nn]* ) clear && main;;
    * ) clear && echo 'Désolé, réessayez.' && quit;;
esac
}

#----- MENU PRINCIPAL -----#
function main {
echo ''
echo '1. Mettre le système à jour ?'
echo '2. Installer les applications conseillées ?'
echo '3. Installer les outils de chiffrement ?'
echo '4. Configurer les paramètres du serveur mandataire ?'
echo '5. Nettoyer le système ?'
echo 'q. Quitter ?'
echo ''
read -p 'Que souhaitez-vous faire ? (Entrez votre choix) : ' REPLY
case $REPLY in
    1) sysupgrade;; # MAJ système
    2) clear && favourites;; # Installation des logiciels
    3) clear && crypto;; # Installation des logiciels de chiffrement
    4) clear && cleanup;; # Nettoyage du système
    [Qq]* ) echo '' && quit;; # Quitter
    * ) clear && echo 'Choix invalide, réessayez.' && main;;
esac
}

#----- EXÉCUTION DU MENU PRINCIPAL -----#
main

#FIN DU SCRIPT
