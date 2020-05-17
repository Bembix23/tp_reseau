# Maîtrise de poste - Day 1

## Self-footprinting

### Host OS

Nous avons la plupart des informations avec la commande "systeminfo". Nous avons même des infos sur les cartes réseau de ma machine donc je vais pouvoir m'en servir plus tard.

```
PS C:\Users\Jules Dupuis> systeminfo

Nom de l’hôte:                              ASUSJULES
Nom du système d’exploitation:              Microsoft Windows 10 Famille
Version du système:                         10.0.18362 N/A version 18362
Fabricant du système d’exploitation:        Microsoft Corporation
Configuration du système d’exploitation:    Station de travail autonome
Type de version du système d’exploitation:  Multiprocessor Free
Propriétaire enregistré:                    Jules Dupuis
Organisation enregistrée:                   N/A
Identificateur de produit:                  00325-96533-97175-AAOEM
Date d’installation originale:              25/08/2019, 01:50:32
Heure de démarrage du système:              28/04/2020, 16:40:29
Fabricant du système:                       ASUSTeK COMPUTER INC.
Modèle du système:                          VivoBook_ASUSLaptop X705FD_N705FD
Type du système:                            x64-based PC
Processeur(s):                              1 processeur(s) installé(s).
                                            [01] : Intel64 Family 6 Model 142 Stepping 11 GenuineIntel ~1792 MHz
Version du BIOS:                            American Megatrends Inc. X705FD.314, 04/07/2019
Répertoire Windows:                         C:\WINDOWS
Répertoire système:                         C:\WINDOWS\system32
Périphérique d’amorçage:                    \Device\HarddiskVolume3
Option régionale du système:                fr;Français (France)
Paramètres régionaux d’entrée:              fr;Français (France)
Fuseau horaire:                             (UTC+01:00) Bruxelles, Copenhague, Madrid, Paris
Mémoire physique totale:                    8 043 Mo
Mémoire physique disponible:                1 992 Mo
Mémoire virtuelle : taille maximale:        16 747 Mo
Mémoire virtuelle : disponible:             6 384 Mo
Mémoire virtuelle : en cours d’utilisation: 10 363 Mo
Emplacements des fichiers d’échange:        D:\pagefile.sys
Domaine:                                    WORKGROUP
Serveur d’ouverture de session:             \\ASUSJULES
```
Nous avons donc le nom de l'hôte qui est ASUSJULES, l'OS de ma machine qui est Windows et sa version, la 10, aux lignes "Nom du systeme d'exploitation" et "Version du systeme". Ici nous savons aussi architecture du processeur, c'est à dire si mon PC est un 64bits ou un 32bits, ici c'est un 64bits et on le voit à la ligne "Type du systeme". Nous avons aussi le processeur à la ligne "Processeur(s)", dans mon cas c'est un "Intel64 Family 6...". On voit aussi la RAM total, ici la "Memoire physique totale", qui est de 8Go.
Pour le modèle de la RAM, il fallait faire une autre commande:
```
wmic memorychip get devicelocator, manufacturer, typedetail, capacity, speed, memorytype
Capacity    DeviceLocator   Manufacturer  MemoryType  Speed  TypeDetail
8589934592  ChannelB-DIMM0  Samsung       0           2400   128
```
Donc ici nous avons toutes les infos de la RAM. La premiere ligne au dessus est la commande à effectuer pour obtenir la sorte de tableau au dessous.

### Devices

Pour avoir toutes les infos du processeur, il faut effectuer la commande suivante:
```
Get-ComputerInfo -Property "*proc*"
```
Nous aurons alors les resultats suivants:
```
CsNumberOfLogicalProcessors : 8
CsNumberOfProcessors        : 1
CsProcessors                : {Intel(R) Core(TM) i7-8565U CPU @ 1.80GHz}
OsMaxNumberOfProcesses      : 4294967295
OsMaxProcessMemorySize      : 137438953344
OsNumberOfProcesses         : 300
```
Le nombre de processeur correspond à la ligne "CsNumberOfProcessors", ici je n'ai qu'un seul processeur, quant au nombre de coeur, c'est la ligne "CsNumerOfLogicalProcessors", ici j'ai 8 coeurs.


![](https://i.imgur.com/utEbRXz.png)

Nous avons sur cette image la description du nom de mon processeur:
le debut "Intel Core" est l'un des noms des processeurs Intel, nous avons ensuite "i7" qui correspond à la puissance du processeur. Le premier chiffre de la séquence de quatre chiffres indique la génération du processeur et les trois chiffres suivants correspondent au numéro de référence. Il y a une lettre après cette serie de chiffre, ici c'est un U, ça correspond à une très basse consommation.

Pour avoir les infos des disques dur principal, il faut effectuer la commande:
```
Get-PhysicalDisk
```
Nous obtenons un tableau avec mes deux disques durs principaux:
```
Number FriendlyName            SerialNumber MediaType CanPool OperationalStatus HealthStatus Usage
------ ------------            ------------ --------- ------- ----------------- ------------ -----
1      SanDisk SD9SN8W128G1102 185037442410 SSD       False   OK                Healthy      Auto-Se...
0      ST1000LM035-1RK172      WL1QKQ9K     HDD       False   OK                Healthy      Auto-Se...
```
Le premier est le "SanDisk SD9SN8W128G1102" et c'est un disque dur SSD, c'est donc le plus rapide des deux. Le deuxieme est le "ST1000LM035-1RK172" et c'est un disque dur HDD.


Pour avoir la liste de mes partitions, on demarre un "DISKPART" sur l'invite de commande puis on peut voir une liste peu detaillée des disques durs de ma machine. 
```
DISKPART> list disk

  N° disque  Statut         Taille   Libre    Dyn  GPT
  ---------  -------------  -------  -------  ---  ---
  Disque 0    En ligne        931 G octets      0 octets        *
  Disque 1    En ligne        119 G octets      0 octets        *
```
Ensuite nous pouvons selectionner un disque dur et voir la liste de ses partitions:
```
DISKPART> select disk 1

Le disque 1 est maintenant le disque sélectionné.

DISKPART> list partition

  N° partition   Type              Taille   Décalage
  -------------  ----------------  -------  --------
  Partition 1    Système            260 M   1024 K
  Partition 2    Réservé             16 M    261 M
  Partition 3    Principale         118 G    277 M
  Partition 4    Récupération       800 M    118 G
```

On retourne sur Powershell et on fait la commande
```
 get-volume
```
pour obtenir les informations sur les systeme de fichiers, on obtient:
```
DriveLetter FriendlyName FileSystemType DriveType HealthStatus OperationalStatus SizeRemaining     Size
----------- ------------ -------------- --------- ------------ ----------------- -------------     ----
D           DATA         NTFS           Fixed     Healthy      OK                    204.72 GB ...68 GB
            RECOVERY     NTFS           Fixed     Healthy      OK                    259.73 MB   800 MB
C           OS           NTFS           Fixed     Healthy      OK                     11.18 GB ...19 GB
```
Donc ici les systemes de fichiers sont NTFS.


Un peu plus haut avec la liste des partitions nous avons leur type et donc leur fonction, la partition 1 sert au systeme, pour qu'il demarre et soit hébergé. La partition 2 est une partition réservée et pas très grande. La partition 3 est la partition générale où seront stockées tous nos fichiers, elle est très grande avec 118Go. La derniere partition est celle de récupération donc elle servira si on a un soucis de machine, elle nous sert de sauvegardes.

### Network

On veut avoir les cartes réseaux, on peut alors refaire la commande du début:
```
systeminfo
``` 
Elle va nous donner toutes les infos de notre machine dont les cartes réseaux:
```
Carte(s) réseau:                            9 carte(s) réseau installée(s).
                                            [01]: TAP-Windows Adapter V9
                                                  Nom de la connexion : Ethernet 2
                                                  État :                Matériel absent
                                            [02]: Intel(R) Wireless-AC 9560 160MHz
                                                  Nom de la connexion : Wi-Fi
                                                  DHCP activé :         Oui
                                                  Serveur DHCP :        192.168.0.254
                                                  Adresse(s) IP
                                                  [01]: 192.168.0.17
                                                  [02]: fe80::7cc0:2322:4a46:52f1
                                                  [03]: 2a01:e34:ef65:7120:2d70:fc16:b96:ee70
                                                  [04]: 2a01:e34:ef65:7120:7cc0:2322:4a46:52f1
                                            [03]: Realtek PCIe GbE Family Controller
                                                  Nom de la connexion : Ethernet
                                                  État :                Support déconnecté
                                            [04]: Bluetooth Device (Personal Area Network)
                                                  Nom de la connexion : Connexion réseau Bluetooth
                                                  État :                Support déconnecté
                                            [05]: VirtualBox Host-Only Ethernet Adapter
                                                  Nom de la connexion : VirtualBox Host-Only Network
                                                  DHCP activé :         Non
                                                  Adresse(s) IP
                                                  [01]: 10.3.2.1
                                                  [02]: fe80::3d07:e938:30ad:ae8b
                                            [06]: VMware Virtual Ethernet Adapter for VMnet1
                                                  Nom de la connexion : VMware Network Adapter VMnet1
                                                  État :                Matériel absent
                                            [07]: VMware Virtual Ethernet Adapter for VMnet8
                                                  Nom de la connexion : VMware Network Adapter VMnet8
                                                  État :                Matériel absent
                                            [08]: VirtualBox Host-Only Ethernet Adapter
                                                  Nom de la connexion : VirtualBox Host-Only Network #3
                                                  DHCP activé :         Non
                                                  Adresse(s) IP
                                                  [01]: 192.168.156.1
                                                  [02]: fe80::b848:b6a7:8514:93d2
                                            [09]: VirtualBox Host-Only Ethernet Adapter
                                                  Nom de la connexion : VirtualBox Host-Only Network #2
                                                  DHCP activé :         Non
                                                  Adresse(s) IP
                                                  [01]: 10.3.1.1
                                                  [02]: fe80::adff:ed80:d60e:473
```
Nous avons donc 9 cartes réseaux:

-la premiere est la carte Ethernet 2, ici elle n'a pas d'utilité car elle n'a pas de matériel connecté

-la deuxieme est la carte Wifi, on voit toutes ses IP

-la troisieme est la carte Ethernet, elle est fonctionnelle mais ici je ne l'utilise pas, c'est pour cela qu'il y a écrit "Support déconnecté"

-la quatrieme est la carte Bluetooth, en ce moment rien n'est connecté en Bluetooth à ma machine donc il affiche "Support déconnecté".

Les suivantes sont des cartes attribuées aux launcheurs de machines virtuelles, VirtualBox et VMWare:

-la carte 5, la carte 8 et la carte 9 sont des cartes pour VirtualBox

-les cartes 6 et 7 sont des cartes pour VMWare.


Pour lister les ports TCP et UDP en utilisation, on utilise la commande :
```
netstat -abo
```
On obtient un énorme pavé de connexions actives avec le protocoles (tcp ou udp), l'adresse locale, l'adresse distante, état (en écoute ou pas) et le port en écoute.
```
Connexions actives

  Proto  Adresse locale         Adresse distante       État
  TCP    0.0.0.0:80             ASUSJules:0            LISTENING       4
 Impossible d’obtenir les informations de propriétaire
  TCP    0.0.0.0:135            ASUSJules:0            LISTENING       1200
  RpcSs
 [svchost.exe]
  TCP    0.0.0.0:445            ASUSJules:0            LISTENING       4
 Impossible d’obtenir les informations de propriétaire
  TCP    0.0.0.0:902            ASUSJules:0            LISTENING       5928
 [vmware-authd.exe]
  TCP    0.0.0.0:912            ASUSJules:0            LISTENING       5928
 [vmware-authd.exe]
  TCP    0.0.0.0:1337           ASUSJules:0            LISTENING       5964
 [RzSDKServer.exe]
  TCP    0.0.0.0:3306           ASUSJules:0            LISTENING       8536
 [mysqld.exe]
  TCP    0.0.0.0:5040           ASUSJules:0            LISTENING       3996
  CDPSvc
 [svchost.exe]
  TCP    0.0.0.0:5357           ASUSJules:0            LISTENING       4
 Impossible d’obtenir les informations de propriétaire
  TCP    0.0.0.0:5426           ASUSJules:0            LISTENING       4
 Impossible d’obtenir les informations de propriétaire
  TCP    0.0.0.0:7680           ASUSJules:0            LISTENING       6916
 Impossible d’obtenir les informations de propriétaire
  TCP    0.0.0.0:33060          ASUSJules:0            LISTENING       8536
 [mysqld.exe]
  TCP    0.0.0.0:49664          ASUSJules:0            LISTENING       764
 [lsass.exe]
  TCP    0.0.0.0:49665          ASUSJules:0            LISTENING       592
 Impossible d’obtenir les informations de propriétaire
  TCP    0.0.0.0:49666          ASUSJules:0            LISTENING       1944
  EventLog
 [svchost.exe]
  TCP    0.0.0.0:49667          ASUSJules:0            LISTENING       1988
  Schedule
 [svchost.exe]
  TCP    0.0.0.0:49668          ASUSJules:0            LISTENING       3360
  SessionEnv
 [svchost.exe]
  TCP    0.0.0.0:49669          ASUSJules:0            LISTENING       5148
 [spoolsv.exe]
  TCP    0.0.0.0:49673          ASUSJules:0            LISTENING       5312
  PolicyAgent
 [svchost.exe]
  TCP    0.0.0.0:49698          ASUSJules:0            LISTENING       684
 Impossible d’obtenir les informations de propriétaire
  TCP    0.0.0.0:54235          ASUSJules:0            LISTENING       4
 Impossible d’obtenir les informations de propriétaire
  TCP    0.0.0.0:54236          ASUSJules:0            LISTENING       4
 Impossible d’obtenir les informations de propriétaire
  TCP    10.3.1.1:139           ASUSJules:0            LISTENING       4
 Impossible d’obtenir les informations de propriétaire
  TCP    10.3.2.1:139           ASUSJules:0            LISTENING       4
 Impossible d’obtenir les informations de propriétaire
  TCP    127.0.0.1:5939         ASUSJules:0            LISTENING       6240
 [TeamViewer_Service.exe]
  TCP    127.0.0.1:9100         ASUSJules:0            LISTENING       5800
 [lghub_updater.exe]
  TCP    127.0.0.1:9180         ASUSJules:0            LISTENING       5800
 [lghub_updater.exe]
  TCP    127.0.0.1:11456        ASUSJules:0            LISTENING       18980
 [DashlanePlugin.exe]
  TCP    127.0.0.1:27275        ASUSJules:0            LISTENING       4996
 Impossible d’obtenir les informations de propriétaire
  TCP    127.0.0.1:49675        ASUSJules:49676        ESTABLISHED     8536
 [mysqld.exe]
  TCP    127.0.0.1:49676        ASUSJules:49675        ESTABLISHED     8536
 [mysqld.exe]
  TCP    127.0.0.1:53779        ASUSJules:65001        ESTABLISHED     5884
 [nvcontainer.exe]
  TCP    127.0.0.1:53858        ASUSJules:0            LISTENING       27952
 [NVIDIA Web Helper.exe]
  TCP    127.0.0.1:53858        ASUSJules:53876        ESTABLISHED     27952
 [NVIDIA Web Helper.exe]
  TCP    127.0.0.1:53876        ASUSJules:53858        ESTABLISHED     19732
 [NVIDIA Share.exe]
  TCP    127.0.0.1:54273        ASUSJules:0            LISTENING       32404
 [Dashlane.exe]
  TCP    127.0.0.1:54426        ASUSJules:0            LISTENING       5952
 [GiftBoxService.exe]
  TCP    127.0.0.1:54493        ASUSJules:0            LISTENING       16520
 [Code.exe]
  TCP    127.0.0.1:54494        ASUSJules:54495        ESTABLISHED     16520
 [Code.exe]
  TCP    127.0.0.1:54495        ASUSJules:54494        ESTABLISHED     30692
 [php.exe]
  TCP    127.0.0.1:65001        ASUSJules:0            LISTENING       5884
 [nvcontainer.exe]
  TCP    127.0.0.1:65001        ASUSJules:53779        ESTABLISHED     5884
 [nvcontainer.exe]
  TCP    192.168.0.17:139       ASUSJules:0            LISTENING       4
 Impossible d’obtenir les informations de propriétaire
  TCP    192.168.0.17:53790     40.67.251.132:https    ESTABLISHED     6088
  WpnService
 [svchost.exe]
  TCP    192.168.0.17:53898     162.159.130.234:https  TIME_WAIT       0
  TCP    192.168.0.17:54040     5.62.53.104:http       ESTABLISHED     4996
 Impossible d’obtenir les informations de propriétaire
  TCP    192.168.0.17:54184     ams10-015:http         ESTABLISHED     4996
 Impossible d’obtenir les informations de propriétaire
  TCP    192.168.0.17:54510     52.236.190.14:https    ESTABLISHED     49460
 [vsls-agent.exe]
  TCP    192.168.0.17:55243     wb-in-f109:imaps       CLOSE_WAIT      37880
 [HxTsr.exe]
  TCP    192.168.0.17:55302     152.199.19.161:https   CLOSE_WAIT      16372
 [SearchUI.exe]
  TCP    192.168.0.17:55305     162.159.128.232:https  TIME_WAIT       0
  TCP    192.168.0.17:55306     104.27.147.194:https   TIME_WAIT       0
  TCP    192.168.0.17:55307     162.159.135.233:https  TIME_WAIT       0
  TCP    192.168.0.17:55314     ec2-54-173-251-32:https  ESTABLISHED     5920
 [RazerCentralService.exe]
  TCP    192.168.0.17:55317     161.47.7.14:http       CLOSE_WAIT      6080
 [ReiGuard.exe]
  TCP    192.168.0.17:55320     ec2-52-204-23-104:https  CLOSE_WAIT      63400
 [EpicGamesLauncher.exe]
  TCP    192.168.0.17:55321     ec2-35-168-30-237:https  ESTABLISHED     63400
 [EpicGamesLauncher.exe]
  TCP    192.168.0.17:55322     a23-213-7-138:http     ESTABLISHED     63400
 [EpicGamesLauncher.exe]
  TCP    192.168.0.17:55323     a23-213-7-138:http     ESTABLISHED     63400
 [EpicGamesLauncher.exe]
  TCP    192.168.0.17:55324     ec2-54-165-234-48:https  ESTABLISHED     63400
 [EpicGamesLauncher.exe]
  TCP    192.168.0.17:55325     a95-101-225-78:https   ESTABLISHED     63400
 [EpicGamesLauncher.exe]
  TCP    192.168.0.17:55328     ec2-52-201-110-118:https  ESTABLISHED     63400
 [EpicGamesLauncher.exe]
  TCP    192.168.0.17:55329     a95-101-225-78:https   ESTABLISHED     63400
 [EpicGamesLauncher.exe]
  TCP    192.168.0.17:55331     ec2-52-209-86-177:https  ESTABLISHED     32404
 [Dashlane.exe]
  TCP    192.168.156.1:139      ASUSJules:0            LISTENING       4
 Impossible d’obtenir les informations de propriétaire
  TCP    [::]:80                ASUSJules:0            LISTENING       4
 Impossible d’obtenir les informations de propriétaire
  TCP    [::]:135               ASUSJules:0            LISTENING       1200
  RpcSs
 [svchost.exe]
  TCP    [::]:445               ASUSJules:0            LISTENING       4
 Impossible d’obtenir les informations de propriétaire
  TCP    [::]:1337              ASUSJules:0            LISTENING       5964
 [RzSDKServer.exe]
  TCP    [::]:3306              ASUSJules:0            LISTENING       8536
 [mysqld.exe]
  TCP    [::]:5357              ASUSJules:0            LISTENING       4
 Impossible d’obtenir les informations de propriétaire
  TCP    [::]:5426              ASUSJules:0            LISTENING       4
 Impossible d’obtenir les informations de propriétaire
  TCP    [::]:7680              ASUSJules:0            LISTENING       6916
 Impossible d’obtenir les informations de propriétaire
  TCP    [::]:33060             ASUSJules:0            LISTENING       8536
 [mysqld.exe]
  TCP    [::]:49664             ASUSJules:0            LISTENING       764
 [lsass.exe]
  TCP    [::]:49665             ASUSJules:0            LISTENING       592
 Impossible d’obtenir les informations de propriétaire
  TCP    [::]:49666             ASUSJules:0            LISTENING       1944
  EventLog
 [svchost.exe]
  TCP    [::]:49667             ASUSJules:0            LISTENING       1988
  Schedule
 [svchost.exe]
  TCP    [::]:49668             ASUSJules:0            LISTENING       3360
  SessionEnv
 [svchost.exe]
  TCP    [::]:49669             ASUSJules:0            LISTENING       5148
 [spoolsv.exe]
  TCP    [::]:49673             ASUSJules:0            LISTENING       5312
  PolicyAgent
 [svchost.exe]
  TCP    [::]:49698             ASUSJules:0            LISTENING       684
 Impossible d’obtenir les informations de propriétaire
  TCP    [::]:54235             ASUSJules:0            LISTENING       4
 Impossible d’obtenir les informations de propriétaire
  TCP    [::]:54236             ASUSJules:0            LISTENING       4
 Impossible d’obtenir les informations de propriétaire
  TCP    [::1]:5426             ASUSJules:53810        ESTABLISHED     4
 Impossible d’obtenir les informations de propriétaire
  TCP    [::1]:5426             ASUSJules:53813        ESTABLISHED     4
 Impossible d’obtenir les informations de propriétaire
  TCP    [::1]:5426             ASUSJules:53816        ESTABLISHED     4
 Impossible d’obtenir les informations de propriétaire
  TCP    [::1]:5426             ASUSJules:53819        ESTABLISHED     4
 Impossible d’obtenir les informations de propriétaire
  TCP    [::1]:27275            ASUSJules:0            LISTENING       4996
 Impossible d’obtenir les informations de propriétaire
  TCP    [::1]:49671            ASUSJules:0            LISTENING       6332
 [jhi_service.exe]
  TCP    [::1]:53810            ASUSJules:5426         ESTABLISHED     35672
 [Razer Synapse Service Process.exe]
  TCP    [::1]:53813            ASUSJules:5426         ESTABLISHED     35672
 [Razer Synapse Service Process.exe]
  TCP    [::1]:53816            ASUSJules:5426         ESTABLISHED     35672
 [Razer Synapse Service Process.exe]
  TCP    [::1]:53819            ASUSJules:5426         ESTABLISHED     35672
 [Razer Synapse Service Process.exe]
  TCP    [2a01:e34:ef65:7120:2d70:fc16:b96:ee70]:54114  g2a02-26f0-00ff-03a1-0000-0000-0000-4106:https  CLOSE_WAIT      47812
 [WinStore.App.exe]
  TCP    [2a01:e34:ef65:7120:2d70:fc16:b96:ee70]:54115  g2a02-26f0-00ff-03a1-0000-0000-0000-4106:https  CLOSE_WAIT      47812
 [WinStore.App.exe]
  TCP    [2a01:e34:ef65:7120:2d70:fc16:b96:ee70]:54116  g2a02-26f0-00ff-03a1-0000-0000-0000-4106:https  CLOSE_WAIT      47812
 [WinStore.App.exe]
  TCP    [2a01:e34:ef65:7120:2d70:fc16:b96:ee70]:54118  g2a02-26f0-00ff-03b3-0000-0000-0000-3114:http  CLOSE_WAIT      47812
 [WinStore.App.exe]
  TCP    [2a01:e34:ef65:7120:2d70:fc16:b96:ee70]:54119  g2a02-26f0-00ff-03b3-0000-0000-0000-3114:http  CLOSE_WAIT      47812
 [WinStore.App.exe]
  TCP    [2a01:e34:ef65:7120:2d70:fc16:b96:ee70]:54120  g2a02-26f0-00e3-0000-0000-0000-5f65-b699:https  CLOSE_WAIT      47812
 [WinStore.App.exe]
  TCP    [2a01:e34:ef65:7120:2d70:fc16:b96:ee70]:54133  g2a02-26f0-00e1-0382-0000-0000-0000-4106:https  CLOSE_WAIT      47812
 [WinStore.App.exe]
  UDP    0.0.0.0:500            *:*                                    5304
  IKEEXT
 [svchost.exe]
  UDP    0.0.0.0:3702           *:*                                    3200
 [dashost.exe]
  UDP    0.0.0.0:3702           *:*                                    3200
 [dashost.exe]
  UDP    0.0.0.0:4500           *:*                                    5304
  IKEEXT
 [svchost.exe]
  UDP    0.0.0.0:5050           *:*                                    3996
  CDPSvc
 [svchost.exe]
  UDP    0.0.0.0:5353           *:*                                    2680
  Dnscache
 [svchost.exe]
  UDP    0.0.0.0:5355           *:*                                    2680
  Dnscache
 [svchost.exe]
  UDP    0.0.0.0:50754          *:*                                    6240
 [TeamViewer_Service.exe]
  UDP    0.0.0.0:50999          *:*                                    3200
 [dashost.exe]
  UDP    0.0.0.0:51721          *:*                                    5884
 [nvcontainer.exe]
  UDP    10.3.1.1:137           *:*                                    4
 Impossible d’obtenir les informations de propriétaire
  UDP    10.3.1.1:138           *:*                                    4
 Impossible d’obtenir les informations de propriétaire
  UDP    10.3.1.1:1900          *:*                                    3988
  SSDPSRV
 [svchost.exe]
  UDP    10.3.1.1:2177          *:*                                    36044
  QWAVE
 [svchost.exe]
  UDP    10.3.1.1:5353          *:*                                    6240
 [TeamViewer_Service.exe]
  UDP    10.3.1.1:5353          *:*                                    5884
 [nvcontainer.exe]
  UDP    10.3.1.1:59702         *:*                                    3988
  SSDPSRV
 [svchost.exe]
  UDP    10.3.2.1:137           *:*                                    4
 Impossible d’obtenir les informations de propriétaire
  UDP    10.3.2.1:138           *:*                                    4
 Impossible d’obtenir les informations de propriétaire
  UDP    10.3.2.1:1900          *:*                                    3988
  SSDPSRV
 [svchost.exe]
  UDP    10.3.2.1:2177          *:*                                    36044
  QWAVE
 [svchost.exe]
  UDP    10.3.2.1:5353          *:*                                    6240
 [TeamViewer_Service.exe]
  UDP    10.3.2.1:5353          *:*                                    5884
 [nvcontainer.exe]
  UDP    10.3.2.1:59700         *:*                                    3988
  SSDPSRV
 [svchost.exe]
  UDP    127.0.0.1:1900         *:*                                    3988
  SSDPSRV
 [svchost.exe]
  UDP    127.0.0.1:10020        *:*                                    27952
 [NVIDIA Web Helper.exe]
  UDP    127.0.0.1:10021        *:*                                    4072
 [nvcontainer.exe]
  UDP    127.0.0.1:26760        *:*                                    6064
 [ScpService.exe]
  UDP    127.0.0.1:50752        *:*                                    5696
  iphlpsvc
 [svchost.exe]
  UDP    127.0.0.1:51314        *:*                                    44784
 [nvcontainer.exe]
  UDP    127.0.0.1:59704        *:*                                    3988
  SSDPSRV
 [svchost.exe]
  UDP    192.168.0.17:137       *:*                                    4
 Impossible d’obtenir les informations de propriétaire
  UDP    192.168.0.17:138       *:*                                    4
 Impossible d’obtenir les informations de propriétaire
  UDP    192.168.0.17:1900      *:*                                    3988
  SSDPSRV
 [svchost.exe]
  UDP    192.168.0.17:2177      *:*                                    36044
  QWAVE
 [svchost.exe]
  UDP    192.168.0.17:5353      *:*                                    5884
 [nvcontainer.exe]
  UDP    192.168.0.17:59703     *:*                                    3988
  SSDPSRV
 [svchost.exe]
  UDP    192.168.156.1:137      *:*                                    4
 Impossible d’obtenir les informations de propriétaire
  UDP    192.168.156.1:138      *:*                                    4
 Impossible d’obtenir les informations de propriétaire
  UDP    192.168.156.1:1900     *:*                                    3988
  SSDPSRV
 [svchost.exe]
  UDP    192.168.156.1:2177     *:*                                    36044
  QWAVE
 [svchost.exe]
  UDP    192.168.156.1:5353     *:*                                    5884
 [nvcontainer.exe]
  UDP    192.168.156.1:5353     *:*                                    6240
 [TeamViewer_Service.exe]
  UDP    192.168.156.1:59701    *:*                                    3988
  SSDPSRV
 [svchost.exe]
  UDP    [::]:500               *:*                                    5304
  IKEEXT
 [svchost.exe]
  UDP    [::]:3702              *:*                                    3200
 [dashost.exe]
  UDP    [::]:3702              *:*                                    3200
 [dashost.exe]
  UDP    [::]:4500              *:*                                    5304
  IKEEXT
 [svchost.exe]
  UDP    [::]:5353              *:*                                    2680
  Dnscache
 [svchost.exe]
  UDP    [::]:5355              *:*                                    2680
  Dnscache
 [svchost.exe]
  UDP    [::]:50755             *:*                                    6240
 [TeamViewer_Service.exe]
  UDP    [::]:51000             *:*                                    3200
 [dashost.exe]
  UDP    [::]:51722             *:*                                    5884
 [nvcontainer.exe]
  UDP    [::1]:1900             *:*                                    3988
  SSDPSRV
 [svchost.exe]
  UDP    [::1]:5353             *:*                                    5884
 [nvcontainer.exe]
  UDP    [::1]:5353             *:*                                    6240
 [TeamViewer_Service.exe]
  UDP    [::1]:59699            *:*                                    3988
  SSDPSRV
 [svchost.exe]
  UDP    [2a01:e34:ef65:7120:2d70:fc16:b96:ee70]:2177  *:*                                    36044
  QWAVE
 [svchost.exe]
  UDP    [2a01:e34:ef65:7120:7cc0:2322:4a46:52f1]:2177  *:*                                    36044
  QWAVE
 [svchost.exe]
  UDP    [fe80::3d07:e938:30ad:ae8b%11]:1900  *:*                                    3988
  SSDPSRV
 [svchost.exe]
  UDP    [fe80::3d07:e938:30ad:ae8b%11]:2177  *:*                                    36044
  QWAVE
 [svchost.exe]
  UDP    [fe80::3d07:e938:30ad:ae8b%11]:59695  *:*                                    3988
  SSDPSRV
 [svchost.exe]
  UDP    [fe80::7cc0:2322:4a46:52f1%16]:1900  *:*                                    3988
  SSDPSRV
 [svchost.exe]
  UDP    [fe80::7cc0:2322:4a46:52f1%16]:2177  *:*                                    36044
  QWAVE
 [svchost.exe]
  UDP    [fe80::7cc0:2322:4a46:52f1%16]:59698  *:*                                    3988
  SSDPSRV
 [svchost.exe]
  UDP    [fe80::adff:ed80:d60e:473%17]:1900  *:*                                    3988
  SSDPSRV
 [svchost.exe]
  UDP    [fe80::adff:ed80:d60e:473%17]:2177  *:*                                    36044
  QWAVE
 [svchost.exe]
  UDP    [fe80::adff:ed80:d60e:473%17]:59697  *:*                                    3988
  SSDPSRV
 [svchost.exe]
  UDP    [fe80::b848:b6a7:8514:93d2%21]:1900  *:*                                    3988
  SSDPSRV
 [svchost.exe]
  UDP    [fe80::b848:b6a7:8514:93d2%21]:2177  *:*                                    36044
  QWAVE
 [svchost.exe]
  UDP    [fe80::b848:b6a7:8514:93d2%21]:59696  *:*                                    3988
  SSDPSRV
 [svchost.exe]
 ```
 Il y a beaucoup d'application que j'utilise comme:
 
 -VMware 
 
 -MySQL 
 
 -TeamViewer
 
 -mon driver pour la souris

 -mon driver pour le clavier

 -Dashlane

 -Nvidia

 -EpicGame Launcher 

 J'ai aussi enormement de lignes avec "svchost" et je ne sais pas à quoi ça correspond.


 ### Users

 Pour avoir la liste complète des utilisateurs de la machine, j'utilise la commande:
 ```
 net user
 ```
 On obtient alors:
 ```
 comptes d’utilisateurs de \\ASUSJULES

-------------------------------------------------------------------------------
Administrateur           DefaultAccount           Invité
Jules Dupuis             WDAGUtilityAccount
La commande s’est terminée correctement.
```
Il n'y a qu'un seul utilisateur, moi, qui suis administrateur.


### Processsus

Nous avons la liste des processus de la machine en faisant la commande:
```
Get-Service | Where{ $_.Status -eq "Running" }
```
Nous obtenons une longue liste de processus en cours, on en choisit donc 5:

-Winmgmt: Infrastructure de gestion Windows

-Wcmsvc: Gestionnaire des connexions Windows

-stisvc: Acquisition d’image Windows (WIA)

-Power: Alimentation

-UserManager: Gestionnaire des utilisateurs

## Scripting

Pour notre premier script on utlise le langage natif ps1 car c'est le langage de Windows Powershell.
```
Jules Dupuis 08/05

echo "Nom de la machine : $env:COMPUTERNAME" 
echo "IP principale : "
Get-NetIPAddress -InterfaceIndex 16 | Format-Table
echo "----------------------------------------------------"
echo "OS : $env:OS" 
echo "Version OS : $((Get-CimInstance Win32_OperatingSystem).version)"  
echo "Date et heure allumage : "
echo "OS à jour ? : "
echo "----------------------------------------------------"
echo "RAM : " 
echo "Utilisation : "
echo "Espace libre : $(Get-CimInstance Win32_PhysicalMemory | Measure-Object -Property capacity -Sum | Foreach {"{0:N2}" -f ([math]::round(($_.Sum / 1GB),2))})"
echo "----------------------------------------------------"
echo "Espace disque"
echo "Espace disque utilise : "
gwmi win32_logicaldisk | Format-Table DeviceId, @{n="Size";e={[math]::Round($_.Size/1GB,2)}},@{n="UsedSpace";e={[math]::Round(($_.Size-$_.FreeSpace)/1GB,2)}}
echo "Espace disque dispo : "
gwmi win32_logicaldisk | Format-Table DeviceId, @{n="Size";e={[math]::Round($_.Size/1GB,2)}},@{n="FreeSpace";e={[math]::Round($_.FreeSpace/1GB,2)}}
echo "----------------------------------------------------"
echo "Liste des Utilisateur : "
Get-LocalUser | Format-Table
echo "----------------------------------------------------"
ping 8.8.8.8
```

Deuxieme script:
```
Start-Sleep -s 10
Restart-Computer
```

## Gestion de softs

Un gestionnaire de paquet nous permet d'installer, de mettre à jour et de désinstaller des logiciels et ce à la volée, "à la vitesse de l'éclair".


Pour installer Chocolatey pour Windows, je fais la commande suivante:
```
Set-ExecutionPolicy Bypass -Scope Process -Force; iex ((New-Object System.Net.WebClient).DownloadString('https://chocolatey.org/install.ps1%27))
```

Et ensuite pour lister les paquets présents, on fait la commande suivante:
```
choco list
```

J'obtiens pas moins de 5421 paquets. Je me permets de pas tous les coller ici ça ferai beaucoup.

## Partage de fichiers