# TP 1

**1]Exploration locale en solo**
```
Carte réseau sans fil Wifi :
Nom : Intel(R) Wireless-AC 9560 160MHz
Adresse MAC : 48-F1-7F-28-E0-83
Adresse IP : 10.33.0.33
```

```
Carte Ethernet Ethernet :
Nom : Realtek PCIe GbE Family Controller
Adresse MAC : 04-D4-C4-6B-F5-82
Mon ordinateur n'etant pas branché en Ethernet, il n'aura donc pas d'adresse IP
```
``` 
Adresse IP de la passerelle de la carte WIFI : 10.33.3.253
```
![](https://i.imgur.com/BquZy7r.png)
```
La passerrelle dans le réseau d'Ynov nous sert à faire communiquer notre réseau 
avec d'autres.
```

```
La commande pour utiliser un ping scan sur le réseau d'Ynov est : nmap -sP 10.33.0.0/22

On aura alors ce résultat:
```
![](https://i.imgur.com/fOufp70.png)
On voit alors toutes les ip qui sont connectées sur le réseau Ynov et la marque de leur appareil.

**2]Exploration locale en duo**
Lors de cette exploration en duo, le pc ayant désactivé l'interface WIFI n'a pas eu accès à Internet, nous n'avons donc pas pû continuer la deuxieme partie. J'ai donc dû passer à la partie III.

**3]Manipulations d'autres outils / protocoles côté client**

```
Carte réseau sans fil Wifi :
Adresse IP du serveur DHCP:10.33.3.254
Bail expirant: mercredi 29 janvier 2020 16:04:49
```

``` 
Pour renouveler notre bail, nous utilisons les lignes de codes suivantes:
ipconfig /flushdns
ipconfig /release
ipconfig /renew  

Le bail sera alors renouvelé.
```

```
Adresse du serveur DNS connue : 192.168.0.254
```
```
Si l'on effectue un lookup avec une adresse URL, l'adresse IP de cette URL nous sera donnée. Si l'on effectue un lookup d'une adresse IP, ça sera l'inverse, son adresse URL nous sera donnée.
```









