# TP 4 - Cisco, Routage, DHCP

## I. Topologie 1 : simple

### B. Définition d'IPs statiques

#### admin1:

Configuration du SELinux:

![](https://i.imgur.com/sTyEXX0.png)

Définition IP statique:

![](https://i.imgur.com/uEyy4Yq.png)

Définition nom d'hote:

![](https://i.imgur.com/ZOP5QaY.png)


#### router1:

Définition d'une IP statique:

![](https://i.imgur.com/UIg8MYP.png)

Définition d'un nom:

On voit sur le screen précédent que le nom du routeur est "routeur1"


guest1:

![](https://i.imgur.com/8Y1M5VK.png)

On voit sur le screen précédent que le nom du VPCS est "guest1"

Vérification:

guest1 à routeur:

![](https://i.imgur.com/P4wYEwx.png)

admin1 à routeur:

![](https://i.imgur.com/NOmbTo2.png)

routeur1 aux deux autres:

![](https://i.imgur.com/H9D7ykq.png)

![](https://i.imgur.com/a9BtzLb.png)

Table ARP:

![](https://i.imgur.com/rfA49yD.png)

 Il y a bien guest1 et admin1.
 
 Les adresses MAC correspondent:
 
 admin1:
 
 ![](https://i.imgur.com/kxQuAGa.png)
 
 guest1:
 
 ![](https://i.imgur.com/i3UnrRH.png)
 
 ### C. Routage
 
 admin1:
 
 ![](https://i.imgur.com/VJxoTbq.png)
 
 guest1:
 
 ![](https://i.imgur.com/3VvL3mH.png)

Vérification:

De admin1 à guest1:

![](https://i.imgur.com/6Es1w6R.png)

De guest1 à admin1:

![](https://i.imgur.com/Yod2Cdl.png)

Trace du guest1 avec le ping à admin1:

![](https://i.imgur.com/HziKDGy.png)

Les paquets pasent bien par le router (10.4.2.254).

## II. Topologie 2: interrupteurs muets

### C. Vérification

admin1 ping guest1:

![](https://i.imgur.com/cs6xAww.png)

guest1 ping admin1:

![](https://i.imgur.com/ehO5djt.png)



![](https://i.imgur.com/4ljvGJ4.png)

Les paquets passent bien par le routeur(10.4.2.254).

## III. Topologie 3: ajout de nœuds et NAT

### 2. Mise en place

### B. VPCS

Après avoir configuré les VPCS comme il faut, on essaie ensuite de ping admin1: 

Pour guest2:

![](https://i.imgur.com/LPlsGoG.png)

Pour guest3:

![](https://i.imgur.com/8hXGSrD.png)

### C. Accès WAN

Configurer le routeur:

![](https://i.imgur.com/rlkakK5.png)

![](https://i.imgur.com/8ZMgVxc.png)

Configurer les clients:

![](https://i.imgur.com/rc58adl.png)

Pour les guest j'ai configuré 3 fois le DNS donc j'ai la photo suivante 3 fois:

![](https://i.imgur.com/XKL5uz4.png)


Vérification:

On ping google.com (8.8.8.8) pour vérifier si ils ont accès à internet:

Le router:

![](https://i.imgur.com/Bde958S.png)


Admin1:

![](https://i.imgur.com/yjTdU0r.png)


A partir de ce moment j'ai eu des soucis avec mes VPCS qui n'avaient pas Internet, j'ai donc utilisé une VM Guest à la place.

Guest1:

![](https://i.imgur.com/ARCnfGE.png)


Résolution de nom:

![](https://i.imgur.com/44RpVsi.png)



## IV. Topologie 4 : home-made DHCP



J'ai tout mis en place, la VM DHCP etait prete. J'ai ensuite ajouté mon port 67 au firewall sur ma VM DHCP: 

![](https://i.imgur.com/VGyVfrC.png)


Je ne peux malheureusement pas faire la suite sans VPCS il me semble.

 














