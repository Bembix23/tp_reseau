# TP 5 - Une "vraie" topologie ?

## I. Toplogie 1 - intro VLAN

### 2. Setup clients

admin2 ping admin1:

![](https://i.imgur.com/imojJa3.png)

guest2 ping guest1:

![](https://i.imgur.com/hHdOLR4.png)


### 3. Setup VLANs

Premier switch:

![](https://i.imgur.com/QbiYi2L.png)

Deuxieme switch:

![](https://i.imgur.com/NUcskp9.png)

Sue les deux:

![](https://i.imgur.com/FZpYSWX.png)


On vérifie que les admins et les guests peuvent se ping entre eux:

![](https://i.imgur.com/KVIs88y.png)

Admins peuvent se ping entre eux 

![](https://i.imgur.com/fIQ1tAa.png)

Guests peuvent se ping entre eux 

On change l'ip d'un guest:

![](https://i.imgur.com/3YIEtoY.png)

On essaye ensuite de ping un admin:

![](https://i.imgur.com/hg1Jrth.png)

Comme prévu ça ne marche pas.


## II. Topologie 2 - VLAN, sous-interface, NAT

### 2. Adressage

guest3 ping guest1:

![](https://i.imgur.com/3fRf7lB.png)

Ca marche bien 

admin3 ping admin1:

![](https://i.imgur.com/GV7qeQd.png)

Ca marche bien

### 3. VLAN

Configuration:

![](https://i.imgur.com/nUIumrK.png)


Vérification:

![](https://i.imgur.com/h81FbLb.png)


J'ai des soucis de VPCS comme au dernier TP donc je n'ai pas pu continuer, j'ai essayé de faire la configuration des sous-interfaces sur le routeur mais il crashait donc impossible. La suite etait infaisable pour moi car les VPCS ont un problème de connection au NAT, dans le dernier tp j'ai pu résoudre ça grâce à des VMs mais là il y avait trop de VPCS donc impossible. C'est dommage.
