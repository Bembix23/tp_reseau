**TP2 Réseau**

# I. Création et utilisation simples d'une VM CentOS

| Name | IP | MAC | Fonction |
| -------- | -------- | -------- | ----|
| lo    | 127.0.0.1     | 00:00:00:00:00:00     | Pouvoir communiquer avec soi-même |
|enp0s3| 10.0.2.15|08:00:27:a0:7f:d8|
|enp0s8|10.2.1.2|08:00:27:55:c9:b7|

Voici la preuve que l'ip a changé, l'ip de enp0s8 a changé.
![reference link](https://i.imgur.com/6sGberd.png)

Je ping mon pc host avec la VM:
![](https://i.imgur.com/wSqTIJm.png)

On fait un scan Nmap avec la commande : nmap -sP 10.2.1.23/24
Et ça affiche cela:

![](https://i.imgur.com/NF3ZQRL.png)
On obtient donc une adresse MAC qui correspond bien à celle du PC Hôte:
![](https://i.imgur.com/b7I4jZo.png)

Les ports TCP et UDP sont en écoute sur la machine.
Le programme dhclient écoute sur le port 68.
le programme sshd écote sur le port 22.
le programme master écoute sur le port 25.

# II. Notion de ports
IP (s) et port (s) que le serveur SSH écoute actuellement.
![](https://i.imgur.com/vt8Fm7N.png)
Connection SSH:
![](https://i.imgur.com/dRL2HQQ.png)

En modifiant le fichier sshd_config, j'ai trouvé la ligne du port sur lequel écoute le serveur SSH, et j'ai choisi de changer pour le numéro 33360. on vérifie donc que le service SSH écoute sur le nouveau port choisi (donc 33360):
![](https://i.imgur.com/9ktFn6I.png)
Ca a donc bien marché.
![](https://i.imgur.com/KtQAA2l.png)
Connection refusée.

J'ai d'abord utlisé cette commande : sudo firewall-cmd --add-port=80/tcp --permanent

Puis j'ai reload le firewall avec : sudo firewall-cmd --reload

J'ai ensuite utilisé mon powershell windows pour tester la connection et elle a été effectué.

Netcat

![](https://i.imgur.com/dkwviKG.png)

J'ai lancé un serveur netcat dans un premier terminal, le serveur écoute donc sur le port 2311. On peut le voir avec la capture au dessus.

![](https://i.imgur.com/ol7FzV0.png)
![](https://i.imgur.com/tqRdW7s.png)

En inversant les roles, le pc hote devient le serveur et la vm le client.

Wireshark

J'envoie un message avec netcat à partir de ma vm:
![](https://i.imgur.com/1L6xAMZ.png)
Je vérifie ensuite avec l'application Wireshark si je recois quelque chose en regardant "VirtualBox Host-Only Network #2".

![](https://i.imgur.com/4vfpRrZ.png)

Je recois effectivement un signal qui correspond au message envoyé.

## III. Routage statique

Pour cette troisième partie, les choses se sont faites en groupe de 5 PC dont deux sans prise ethernet.

### A. PC1

J'ai réalisé toutes les opérations et j'ai réussi à ping le pc2 : 
PS C:\WINDOWS\system32> route add 10.2.2.1/24 mask 255.255.255.0 10.2.12.2
 OK!
PS C:\WINDOWS\system32> ping 10.2.2.1

Envoi d’une requête 'Ping'  10.2.2.1 avec 32 octets de données :
Réponse de 10.2.2.1 : octets=32 temps=2 ms TTL=127
Réponse de 10.2.2.1 : octets=32 temps=1 ms TTL=127
Réponse de 10.2.2.1 : octets=32 temps=2 ms TTL=127
Réponse de 10.2.2.1 : octets=32 temps=2 ms TTL=127

Statistiques Ping pour 10.2.2.1:
    Paquets : envoyés = 4, reçus = 4, perdus = 0 (perte 0%),
Durée approximative des boucles en millisecondes :
    Minimum = 1ms, Maximum = 2ms, Moyenne = 1ms

### B. PC2

![](https://i.imgur.com/F5XVpzT.png)

### C. VM1

Je réussi a ping le PC2 depuis la VM1 : 
![](https://i.imgur.com/LOb6LpZ.png)

### D.VM2

La VM2 réussi a ping le PC1 : 
![](https://i.imgur.com/oxFrK0F.png)


### E. El gran final

La VM1 arrive a ping la VM2 : 
![](https://i.imgur.com/foCZ3wr.png)

## 3. Configuration des noms de domaine

Après la configuration des noms de domaine, je peux ping la vm2 depuis la vm1 grâce à son nom de domaine :

![](https://i.imgur.com/kajCL8t.png)

Le traceroute : 

![](https://i.imgur.com/UyvGlzf.png)

Et enfin le netcat côté serveur : 

![](https://i.imgur.com/mr7KwxU.png)

Côté client : 
![](https://i.imgur.com/BwbHXJr.png)