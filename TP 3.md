# TP 3 - Routage, ARP, Spéléologie réseau

On prépare tout d'abord les trois VM, le client, le serveur et le router.

## 2. Mise en place du lab
### VM1 : Client
Carte NAT désactivée : 
```

[user@client1 ~]$ ip a
1: lo: <LOOPBACK,UP,LOWER_UP> mtu 65536 qdisc noqueue state UNKNOWN group default qlen 1000
    link/loopback 00:00:00:00:00:00 brd 00:00:00:00:00:00
    inet 127.0.0.1/8 scope host lo
       valid_lft forever preferred_lft forever
    inet6 ::1/128 scope host
       valid_lft forever preferred_lft forever
2: enp0s3: <BROADCAST,MULTICAST,UP,LOWER_UP> mtu 1500 qdisc pfifo_fast state UP group default qlen 1000
    link/ether 08:00:27:d8:26:23 brd ff:ff:ff:ff:ff:ff
3: enp0s8: <BROADCAST,MULTICAST,UP,LOWER_UP> mtu 1500 qdisc pfifo_fast state UP group default qlen 1000
    link/ether 08:00:27:23:d1:4a brd ff:ff:ff:ff:ff:ff
    inet 10.3.1.11/24 brd 10.3.1.255 scope global noprefixroute enp0s8
       valid_lft forever preferred_lft forever
    inet6 fe80::a00:27ff:fe23:d14a/64 scope link
       valid_lft forever preferred_lft forever

```
       
Serveur SSH fonctionnel qui écoute sur le port 7777/tcp:

```

[user@client1 ~]$ ss -ltnp
State      Recv-Q Send-Q       Local Address:Port                      Peer Address:Port
LISTEN     0      100              127.0.0.1:25                                   *:*
LISTEN     0      128                      *:7777                                 *:*
LISTEN     0      100                  [::1]:25                                [::]:*
LISTEN     0      128                   [::]:7777                              [::]:*

```

Pare-feu activé et configuré:

``` 

[user@client1 ~]$ sudo firewall-cmd --list-all
[sudo] password for user:
public (active)
  target: default
  icmp-block-inversion: no
  interfaces: enp0s8
  sources:
  services: dhcpv6-client ssh
  ports: 7777/tcp
  protocols:
  masquerade: no
  forward-ports:
  source-ports:
  icmp-blocks:
  rich rules:
  

```

Nom configuré:

```

[user@client1 ~]$ hostname
client1.net1.tp3

```

Fichiers /etc/hosts de toutes les machines configurés:

```

[user@client1 ~]$ cat /etc/hosts
127.0.0.1   localhost localhost.localdomain localhost4 localhost4.localdomain4
::1         localhost localhost.localdomain localhost6 localhost6.localdomain6
10.3.2.11   serveur1 serveur1.net2.tp3
10.3.1.254  router router.tp3

```

### VM2 : Server
Carte NAT désactivée:

```

[user@serveur1 ~]$ ip a
1: lo: <LOOPBACK,UP,LOWER_UP> mtu 65536 qdisc noqueue state UNKNOWN group default qlen 1000
    link/loopback 00:00:00:00:00:00 brd 00:00:00:00:00:00
    inet 127.0.0.1/8 scope host lo
       valid_lft forever preferred_lft forever
    inet6 ::1/128 scope host
       valid_lft forever preferred_lft forever
2: enp0s3: <BROADCAST,MULTICAST,UP,LOWER_UP> mtu 1500 qdisc pfifo_fast state UP group default qlen 1000
    link/ether 08:00:27:d8:26:23 brd ff:ff:ff:ff:ff:ff
3: enp0s8: <BROADCAST,MULTICAST,UP,LOWER_UP> mtu 1500 qdisc pfifo_fast state UP group default qlen 1000
    link/ether 08:00:27:16:b3:f2 brd ff:ff:ff:ff:ff:ff
    inet 10.3.2.11/24 brd 10.3.2.255 scope global noprefixroute enp0s8
       valid_lft forever preferred_lft forever
    inet6 fe80::a00:27ff:fe16:b3f2/64 scope link
       valid_lft forever preferred_lft forever

```

Serveur SSH fonctionnel qui écoute sur le port 7777/tcp:

```

[user@serveur1 ~]$ ss -ltnp
State      Recv-Q Send-Q       Local Address:Port                      Peer Address:Port
LISTEN     0      100              127.0.0.1:25                                   *:*
LISTEN     0      128                      *:7777                                 *:*
LISTEN     0      100                  [::1]:25                                [::]:*
LISTEN     0      128                   [::]:7777                              [::]:*

```

Pare-feu activé et configuré:

```

[user@serveur1 ~]$ sudo firewall-cmd --list-all
[sudo] password for user:
public (active)
target: default
icmp-block-inversion: no
interfaces: enp0s8
sources:
services: dhcpv6-client ssh
ports: 7777/tcp
protocols:
masquerade: no
forward-ports:
source-ports:
icmp-blocks:
rich rules:

```

Nom configuré:

```

[user@serveur1 ~]$ hostname
serveur1.net2.tp3

```

Fichiers /etc/hosts de toutes les machines configurés:

```

[user@serveur1 ~]$ cat /etc/hosts
127.0.0.1   localhost localhost.localdomain localhost4 localhost4.localdomain4
::1         localhost localhost.localdomain localhost6 localhost6.localdomain6
10.3.1.11   client1 client1.net1.tp3
10.3.2.254  router router.tp3

```

### VM3 : Router
Carte NAT désactivée:

```

[user@router ~]$ ip a
1: lo: <LOOPBACK,UP,LOWER_UP> mtu 65536 qdisc noqueue state UNKNOWN group default qlen 1000
    link/loopback 00:00:00:00:00:00 brd 00:00:00:00:00:00
    inet 127.0.0.1/8 scope host lo
       valid_lft forever preferred_lft forever
    inet6 ::1/128 scope host
       valid_lft forever preferred_lft forever
2: enp0s3: <BROADCAST,MULTICAST,UP,LOWER_UP> mtu 1500 qdisc pfifo_fast state UP group default qlen 1000
    link/ether 08:00:27:d8:26:23 brd ff:ff:ff:ff:ff:ff
3: enp0s8: <BROADCAST,MULTICAST,UP,LOWER_UP> mtu 1500 qdisc pfifo_fast state UP group default qlen 1000
    link/ether 08:00:27:cf:4d:eb brd ff:ff:ff:ff:ff:ff
    inet 10.3.1.254/24 brd 10.3.1.255 scope global noprefixroute enp0s8
       valid_lft forever preferred_lft forever
    inet6 fe80::a00:27ff:fecf:4deb/64 scope link
       valid_lft forever preferred_lft forever
4: enp0s9: <BROADCAST,MULTICAST,UP,LOWER_UP> mtu 1500 qdisc pfifo_fast state UP group default qlen 1000
    link/ether 08:00:27:81:80:f6 brd ff:ff:ff:ff:ff:ff
    inet 10.3.2.254/24 brd 10.3.2.255 scope global noprefixroute enp0s9
       valid_lft forever preferred_lft forever
    inet6 fe80::a00:27ff:fe81:80f6/64 scope link
       valid_lft forever preferred_lft forever

```

Serveur SSH fonctionnel qui écoute sur le port 7777/tcp:

```

[user@router ~]$ ss -ltnp
State      Recv-Q Send-Q       Local Address:Port                      Peer Address:Port
LISTEN     0      100              127.0.0.1:25                                   *:*
LISTEN     0      128                      *:7777                                 *:*
LISTEN     0      100                  [::1]:25                                [::]:*
LISTEN     0      128                   [::]:7777                              [::]:*

```

Pare-feu activé et configuré:

```

[user@router ~]$ sudo firewall-cmd --list-all
[sudo] password for user:
public (active)
target: default
icmp-block-inversion: no
interfaces: enp0s8 enp0s9
sources:
services: dhcpv6-client ssh
ports: 7777/tcp
protocols:
masquerade: no
forward-ports:
source-ports:
icmp-blocks:
rich rules:

```

Nom configuré:

```

[user@router ~]$ hostname
router.tp3

```

Fichiers /etc/hosts de toutes les machines configurés:

```

[user@router ~]$ cat /etc/hosts
127.0.0.1   localhost localhost.localdomain localhost4 localhost4.localdomain4
::1         localhost localhost.localdomain localhost6 localhost6.localdomain6
10.3.1.11   client1 client1.net1.tp3
10.3.2.11   server1 server1.net2.tp3
10.3.1.254  router router.tp3
10.3.2.254  router router.tp3

```

  

Réseaux et adressage des machines:

Depuis client1, ping router doit marcher:

```

[user@client1 ~]$ ping 10.3.1.254
PING 10.3.1.254 (10.3.1.254) 56(84) bytes of data.
64 bytes from 10.3.1.254: icmp_seq=1 ttl=64 time=0.760 ms
64 bytes from 10.3.1.254: icmp_seq=2 ttl=64 time=0.319 ms
64 bytes from 10.3.1.254: icmp_seq=3 ttl=64 time=0.274 ms

```

Depuis router, ping client1 doit marcher:

```

[user@router ~]$ ping 10.3.1.11
PING 10.3.1.11 (10.3.1.11) 56(84) bytes of data.
64 bytes from 10.3.1.11: icmp_seq=1 ttl=64 time=0.354 ms
64 bytes from 10.3.1.11: icmp_seq=2 ttl=64 time=0.303 ms
64 bytes from 10.3.1.11: icmp_seq=3 ttl=64 time=0.494 ms

```

Depuis server1, ping router doit marcher:

```

[user@serveur1 ~]$ ping 10.3.2.254
PING 10.3.2.254 (10.3.2.254) 56(84) bytes of data.
64 bytes from 10.3.2.254: icmp_seq=1 ttl=64 time=0.669 ms
64 bytes from 10.3.2.254: icmp_seq=2 ttl=64 time=0.353 ms
64 bytes from 10.3.2.254: icmp_seq=3 ttl=64 time=0.381 ms

```

Depuis router, ping server1 doit marcher:

```

[user@router ~]$ ping 10.3.2.11
PING 10.3.2.11 (10.3.2.11) 56(84) bytes of data.
64 bytes from 10.3.2.11: icmp_seq=1 ttl=64 time=0.227 ms
64 bytes from 10.3.2.11: icmp_seq=2 ttl=64 time=0.280 ms
64 bytes from 10.3.2.11: icmp_seq=3 ttl=64 time=0.238 ms

```

## I. Mise en place du routage

### 1. Configuration du routage sur router

```

[user@router ~]$ sudo sysctl -w net.ipv4.conf.all.forwarding=1
[sudo] password for user:
net.ipv4.conf.all.forwarding = 1

```

### 2. Ajouter les routes statiques
Client1 puisse joindre net2:

```

[user@client1 ~]$ ip r s
10.3.1.0/24 dev enp0s8 proto kernel scope link src 10.3.1.11 metric 100
10.3.2.0/24 via 10.3.1.254 dev enp0s8 proto static metric 100

```

Server1 puisse joindre net1:

```

[user@serveur1 ~]$ ip r s
10.3.1.0/24 via 10.3.2.254 dev enp0s8 proto static metric 100
10.3.2.0/24 dev enp0s8 proto kernel scope link src 10.3.2.11 metric 100

```

Test de ping le server avec le client:

```

[user@client1 ~]$ ping 10.3.2.11
PING 10.3.2.11 (10.3.2.11) 56(84) bytes of data.
64 bytes from 10.3.2.11: icmp_seq=1 ttl=63 time=1.02 ms
64 bytes from 10.3.2.11: icmp_seq=2 ttl=63 time=0.851 ms
64 bytes from 10.3.2.11: icmp_seq=3 ttl=63 time=1.14 ms
64 bytes from 10.3.2.11: icmp_seq=4 ttl=63 time=0.576 ms
--- 10.3.2.11 ping statistics ---
4 packets transmitted, 4 received, 0% packet loss, time 3006ms
rtt min/avg/max/mdev = 0.576/0.898/1.143/0.216 ms

```

Vérification du passage par router avec la commande traceroute:

```

[user@client1 ~]$ traceroute 10.3.2.11
traceroute to 10.3.2.11 (10.3.2.11), 30 hops max, 60 byte packets
 1  router (10.3.1.254)  0.289 ms  0.274 ms  0.235 ms
 2  router (10.3.1.254)  0.199 ms !X  0.163 ms !X  0.127 ms !X

 ```
### 3. Comprendre le routage

 
|  | Mac src | Mac dst | IP src | IP dst |
| -------- | -------- | -------- | -------- | -------- |
| Dans net1 (trame qui entre dans router)     | 08:00:27:23:d1:4a    | 08:00:27:cf:4d:eb    | 10.3.1.11     | 10.3.2.11     |
| Dans net2 (trame qui sort de router)     | 08:00:27:81:80:f6     | 08:00:27:16:b3:f2     | 10.3.1.11     | 10.3.2.11     |

## II. ARP
### 1. Tables ARP

```

[user@client1 ~]$ ip neigh show
10.3.1.1 dev enp0s8 lladdr 0a:00:27:00:00:11 REACHABLE
10.3.1.254 dev enp0s8 lladdr 08:00:27:cf:4d:eb STALE

```

```

[user@serveur1 ~]$ ip neigh show
10.3.2.254 dev enp0s8 lladdr 08:00:27:81:80:f6 STALE
10.3.2.1 dev enp0s8 lladdr 0a:00:27:00:00:0b REACHABLE

```

```

[user@router ~]$ ip neigh show
10.3.2.11 dev enp0s9 lladdr 08:00:27:16:b3:f2 STALE
10.3.1.11 dev enp0s8 lladdr 08:00:27:23:d1:4a STALE
10.3.2.1 dev enp0s9 lladdr 0a:00:27:00:00:0b REACHABLE
10.3.1.1 dev enp0s8 lladdr 0a:00:27:00:00:11 STALE

```

Les adresses ip affichées sont les ip voisines, elles sont associées. lladdr et l'adresse ensuite correspondent à l'adresse MAC de ces ip. Il a ensuite les derniers mots de nos lignes:
 STALE : entrée valide mais suspecte ; 
 REACHABLE : entrée valide mais qui expire au bout d'un delai.

### 2. Requêtes ARP
#### A. Table ARP 1
Après avoir vidé les tables de client et de router:

````

[user@client1 ~]$ ping 10.3.2.11
PING 10.3.2.11 (10.3.2.11) 56(84) bytes of data.
64 bytes from 10.3.2.11: icmp_seq=1 ttl=63 time=0.855 ms
64 bytes from 10.3.2.11: icmp_seq=2 ttl=63 time=0.813 ms
--- 10.3.2.11 ping statistics ---
2 packets transmitted, 2 received, 0% packet loss, time 1001ms
rtt min/avg/max/mdev = 0.813/0.834/0.855/0.021 ms

````

Le ping fonctionne donc bien.

````

[user@client1 ~]$ ip neigh show
10.3.1.1 dev enp0s8 lladdr 0a:00:27:00:00:11 REACHABLE

````

Nous avons une ligne en moins dans la table ARP.
#### B. Table ARP 2
Après avoir vidé les tables ARP de client, server et router, on ping server avec client:

````

[user@client1 ~]$ ping 10.3.2.11
PING 10.3.2.11 (10.3.2.11) 56(84) bytes of data.
64 bytes from 10.3.2.11: icmp_seq=1 ttl=63 time=1.46 ms
64 bytes from 10.3.2.11: icmp_seq=2 ttl=63 time=0.518 ms
64 bytes from 10.3.2.11: icmp_seq=3 ttl=63 time=0.641 ms
64 bytes from 10.3.2.11: icmp_seq=4 ttl=63 time=0.612 ms
64 bytes from 10.3.2.11: icmp_seq=5 ttl=63 time=0.483 ms

````

Après l'avoir vidé et restart, il y a une ligne en moins dans la table ARP:

````

10.3.2.1 dev enp0s8 lladdr 0a:00:27:00:00:0b REACHABLE

````

#### C. tcpdump 1

````

79	73.363117	PcsCompu_23:d1:4a	Broadcast	ARP	60	Who has 10.3.1.254? Tell 10.3.1.11
80	73.363140	PcsCompu_cf:4d:eb	PcsCompu_23:d1:4a	ARP	42	10.3.1.254 is at 08:00:27:cf:4d:eb

````


#### D. tcpdump 2

````

10	6.860176	PcsCompu_23:d1:4a	Broadcast	ARP	60	Who has 10.3.1.254? Tell 10.3.1.11
11	6.860195	PcsCompu_cf:4d:eb	PcsCompu_23:d1:4a	ARP	42	10.3.1.254 is at 08:00:27:cf:4d:eb

````

````

24	11.865761	PcsCompu_cf:4d:eb	PcsCompu_23:d1:4a	ARP	42	Who has 10.3.1.11? Tell 10.3.1.254
25	11.866130	PcsCompu_23:d1:4a	PcsCompu_cf:4d:eb	ARP	60	10.3.1.11 is at 08:00:27:23:d1:4a

````

#### E. u okay bro ?

On voit tout d'abord qu'il y a des tentatives de connexions de client1 avec router, le router donne donc son adresse MAC. Il y a ensuite le même chose mais entre client et server, le client donne alors son adresse MAC au server

### Entracte : Donner un accès internet aux VMs
Ajout d'une route par défaut:

````

[user@client1 ~]$ cat /etc/sysconfig/network
# Created by anaconda
GATEWAY=10.3.1.254

````

Configuration d'un serveur DNS:

````

[user@client1 ~]$ cat /etc/resolv.conf
# Generated by NetworkManager
search net1.tp3
nameserver 1.1.1.1

````

Ping 8.8.8.8:

````

[user@client1 ~]$ ping 8.8.8.8
PING 8.8.8.8 (8.8.8.8) 56(84) bytes of data.
64 bytes from 8.8.8.8: icmp_seq=1 ttl=53 time=140 ms
64 bytes from 8.8.8.8: icmp_seq=2 ttl=53 time=165 ms
64 bytes from 8.8.8.8: icmp_seq=3 ttl=53 time=247 ms
64 bytes from 8.8.8.8: icmp_seq=4 ttl=53 time=249 ms
64 bytes from 8.8.8.8: icmp_seq=5 ttl=53 time=169 ms
64 bytes from 8.8.8.8: icmp_seq=6 ttl=53 time=186 ms
64 bytes from 8.8.8.8: icmp_seq=7 ttl=53 time=249 ms

````

Dig google.com:

````  

[user@client1 ~]$ dig google.com

; <<>> DiG 9.11.4-P2-RedHat-9.11.4-9.P2.el7 <<>> google.com
;; global options: +cmd
;; Got answer:
;; ->>HEADER<<- opcode: QUERY, status: NOERROR, id: 36097
;; flags: qr rd ra; QUERY: 1, ANSWER: 1, AUTHORITY: 0, ADDITIONAL: 1

;; OPT PSEUDOSECTION:
; EDNS: version: 0, flags:; udp: 1452
;; QUESTION SECTION:
;google.com.                    IN      A

;; ANSWER SECTION:
google.com.             126     IN      A       216.58.206.238

;; Query time: 300 msec
;; SERVER: 1.1.1.1#53(1.1.1.1)
;; WHEN: Tue Mar 17 12:50:22 CET 2020
;; MSG SIZE  rcvd: 55

````

Installation de paquet:

````

[user@client1 ~]$ sudo yum install -y epel-release
[sudo] password for user:
Loaded plugins: fastestmirror
Loading mirror speeds from cached hostfile
 * base: mirrors.ircam.fr
 * extras: ftp.pasteur.fr
 * updates: ftp.pasteur.fr
base                                                                             | 3.6 kB  00:00:00
extras                                                                           | 2.9 kB  00:00:00
updates                                                                          | 2.9 kB  00:00:00
Resolving Dependencies
--> Running transaction check
---> Package epel-release.noarch 0:7-11 will be installed
--> Finished Dependency Resolution

Dependencies Resolved

========================================================================================================
 Package                      Arch                   Version               Repository              Size
========================================================================================================
Installing:
 epel-release                 noarch                 7-11                  extras                  15 k

Transaction Summary
========================================================================================================
Install  1 Package

Total download size: 15 k
Installed size: 24 k
Downloading packages:
epel-release-7-11.noarch.rpm                                                     |  15 kB  00:00:06
Running transaction check
Running transaction test
Transaction test succeeded
Running transaction
  Installing : epel-release-7-11.noarch                                                             1/1
  Verifying  : epel-release-7-11.noarch                                                             1/1

Installed:
  epel-release.noarch 0:7-11

Complete!

````

````

[user@client1 ~]$ sudo yum install -y sl
Loaded plugins: fastestmirror
Loading mirror speeds from cached hostfile
epel/x86_64/metalink                                                             |  21 kB  00:00:00
 * base: mirrors.ircam.fr
 * epel: mir01.syntis.net
 * extras: ftp.pasteur.fr
 * updates: ftp.pasteur.fr
epel                                                                             | 5.3 kB  00:00:00
(1/3): epel/x86_64/group_gz                                                      |  95 kB  00:00:02
(2/3): epel/x86_64/updateinfo                                                    | 1.0 MB  00:00:04
(3/3): epel/x86_64/primary_db                                                    | 6.7 MB  00:00:48
Resolving Dependencies
--> Running transaction check
---> Package sl.x86_64 0:5.02-1.el7 will be installed
--> Finished Dependency Resolution

Dependencies Resolved

========================================================================================================
 Package             Arch                    Version                        Repository             Size
========================================================================================================
Installing:
 sl                  x86_64                  5.02-1.el7                     epel                   14 k

Transaction Summary
========================================================================================================
Install  1 Package

Total download size: 14 k
Installed size: 17 k
Downloading packages:
warning: /var/cache/yum/x86_64/7/epel/packages/sl-5.02-1.el7.x86_64.rpm: Header V3 RSA/SHA256 Signature, key ID 352c64e5: NOKEY
Public key for sl-5.02-1.el7.x86_64.rpm is not installed
sl-5.02-1.el7.x86_64.rpm                                                         |  14 kB  00:00:01
Retrieving key from file:///etc/pki/rpm-gpg/RPM-GPG-KEY-EPEL-7
Importing GPG key 0x352C64E5:
 Userid     : "Fedora EPEL (7) <epel@fedoraproject.org>"
 Fingerprint: 91e9 7d7c 4a5e 96f1 7f3e 888f 6a2f aea2 352c 64e5
 Package    : epel-release-7-11.noarch (@extras)
 From       : /etc/pki/rpm-gpg/RPM-GPG-KEY-EPEL-7
Running transaction check
Running transaction test
Transaction test succeeded
Running transaction
  Installing : sl-5.02-1.el7.x86_64                                                                 1/1
  Verifying  : sl-5.02-1.el7.x86_64                                                                 1/1

Installed:
  sl.x86_64 0:5.02-1.el7

Complete!

````

## III. Plus de tcpdump

### 1. TCP et UDP
#### A. Warm-up
On se connecte en Netcat:
En TCP:
sur le server

````

[user@serveur1 ~]$ nc -l -t -p 9999
salut

````

sur le client

````

[user@client1 ~]$ nc -t 10.3.2.11 9999
salut

````

En UDP:
sur le serveur

````

[user@serveur1 ~]$ nc -l -u -p 9999

salut salut

````

sur le client

````

[user@client1 ~]$ nc -u 10.3.2.11 9999
salut salut

````

#### B. Analyse de trames
##### TCP:
Quand on envoie des messages:

````

17	12.238753	10.3.1.11	10.3.2.11	TCP	73	36132 → 9999 [PSH, ACK] Seq=1 Ack=1 Win=29312 Len=7 TSval=6084042 TSecr=6080450

````

Le 3-Way Handshake TCP:

````

11	9.271719	10.3.1.11	10.3.2.11	TCP	74	36132 → 9999 [SYN] Seq=0 Win=29200 Len=0 MSS=1460 SACK_PERM=1 TSval=6081075 TSecr=0 WS=128
12	9.272102	10.3.2.11	10.3.1.11	TCP	74	9999 → 36132 [SYN, ACK] Seq=0 Ack=1 Win=28960 Len=0 MSS=1460 SACK_PERM=1 TSval=6080450 TSecr=6081075 WS=128
13	9.272384	10.3.1.11	10.3.2.11	TCP	66	36132 → 9999 [ACK] Seq=1 Ack=1 Win=29312 Len=0 TSval=6081076 TSecr=6080450

````

##### UDP:
On réalise exactement les mêmes choses en UDP, on remarque qu'il n'y a pas de 3-Way Handshake.
### 2. SSH
On se connecte en SSH à server depuis client:

````

[user@client1 ~]$ ssh user@10.3.2.11 -p 7777
The authenticity of host '[10.3.2.11]:7777 ([10.3.2.11]:7777)' can't be established.
ECDSA key fingerprint is SHA256:3wtssItKrIixgbKnNObsKVq5Bc8/hkjU5NSIN2n0kOA.
ECDSA key fingerprint is MD5:eb:35:cc:68:ca:89:9c:c4:1b:42:ba:45:c6:80:7c:bc.
Are you sure you want to continue connecting (yes/no)? yes
Warning: Permanently added '[10.3.2.11]:7777' (ECDSA) to the list of known hosts.
user@10.3.2.11's password:
Last login: Tue Mar 17 12:20:50 2020 from 10.3.2.1

````

Avec le tcpdump, on remarque qu'il y a un 3-Way Handshake, on confirme donc que c'est une connexion SSH en TCP:

````

13	4.876877	10.3.1.11	10.3.2.11	TCP	74	47552 → 7777 [SYN] Seq=0 Win=29200 Len=0 MSS=1460 SACK_PERM=1 TSval=7400695 TSecr=0 WS=128
14	4.877235	10.3.2.11	10.3.1.11	TCP	74	7777 → 47552 [SYN, ACK] Seq=0 Ack=1 Win=28960 Len=0 MSS=1460 SACK_PERM=1 TSval=7400071 TSecr=7400695 WS=128
15	4.877480	10.3.1.11	10.3.2.11	TCP	66	47552 → 7777 [ACK] Seq=1 Ack=1 Win=29312 Len=0 TSval=7400696 TSecr=7400071

````



 


