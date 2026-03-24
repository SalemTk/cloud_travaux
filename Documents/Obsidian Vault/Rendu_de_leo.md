sudo dnf remove docker    docker-client                   docker-client-latest                   docker-common                   docker-latest                   docker-latest-logrotate                   docker-logrotate                   docker-selinux                   docker-engine-selinux                   docker-engine
    sudo dnf config-manager addrepo --from-repofile https://download.docker.com/linux/fedora/docker-ce.repo
    sudo dnf install docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin
    sudo systemctl enable --now docker
    sudo systemctl disable docker
	sudo systemctl start docker
    sudo usermod -aG docker $(whoami)



newgrp docker (a defaut de restart mon system ;) 
ou tout simplement reboot
docker run nginx
docker run -p 8080:80 nginx
docker run -p 9999:80 nginx

docker run -d \
  --name meow \
  --memory 512m \
  -p 7777:7777 \
  -v ~/cour_cloud/nginx.conf:/etc/nginx/conf.d/meow.conf \
  -v ~/cour_cloud/index.html:/var/www/tp_docker/index.html \
  nginx
echo "FROM debian

RUN apt update -y

RUN apt install -y apache2

COPY apache2.conf /etc/apache2/

RUN mkdir /etc/apache2/logs/

CMD ["apache2ctl", "-D", "FOREGROUND"]


"  > Dockerfile

echo "services:

  db:
    image: postgres:15-alpine
    environment:
      POSTGRES_DB: wiki
      POSTGRES_PASSWORD: wikijsrocks
      POSTGRES_USER: wikijs
    logging:
      driver: none
    restart: unless-stopped
    volumes:
      - db-data:/var/lib/postgresql/data

  wiki:
    image: ghcr.io/requarks/wiki:2
    depends_on:
      - db
    environment:
      DB_TYPE: postgres
      DB_HOST: db
      DB_PORT: 5432
      DB_USER: wikijs
      DB_PASS: wikijsrocks
      DB_NAME: wiki
    restart: unless-stopped
    ports:
      - "80:3000"

volumes:
  db-data:
" > compose.yml



echo "FROM python:3

WORKDIR /app

COPY requirements.txt .

RUN pip install -r requirements.txt

COPY . .

CMD ["python", "app.py"]
" > FIle   #DockerFile

echo "version: "3"

services:
  app:
    build:
      context: .
      dockerfile: File
    ports:
      - "8888:8888"

  db:
    image: redis
    ports:
      - "6379:6379"
" > dock_compose.yml

docker-compose -f dock-compose.yml up



docker run -v /:/host -it ubuntu chroot /host bash

Preuve : cat /etc/shadow
"root:!:::::::
bin:!*:20294::::::
daemon:!*:20294::::::
"


sudo dnf install trivy
trivy image nginx
trivy image tkt
trivy image requarks/wiki


docker run --rm -it \
  --net host \
  --pid host \
  --userns host \
  --cap-add audit_control \
  -v /etc:/etc:ro \
  -v /lib/systemd/system:/lib/systemd/system:ro \
  -v /var/lib:/var/lib:ro \
  -v /var/run/docker.sock:/var/run/docker.sock:ro \
	  docker/docker-bench-security
	  
	  
	  


TP2:


**Déterminer quel algorithme de chiffrement utiliser pour vos clés**
- donner une source fiable qui explique pourquoi on évite RSA désormais (pour les connexions SSH notamment)
https://www.revue-banque.fr/technologie/systemes-d-information/la-mort-annoncee-de-l-algorithme-rsa-KN24290497
- donner une source fiable qui recommande un autre algorithme de chiffrement (pour les connexions SSH notamment)
https://www.ssh.com/academy/ssh/keygen#ed25519


### B. Génération de votre paire de clés

Algo choisiEd25519
Génération clé`ssh-keygen -t ed25519 -f ~/.ssh/cloud_tp1`
Démarrage agent`eval "$(ssh-agent -s)"`
Ajout clé agent`ssh-add ~/.ssh/cloud_tp1`
Vérification`ssh-add -l`




## 1. Depuis la WebUI[]
```
joblesstk@fedora:~$ ssh azureuser@9.205.16.129
The authenticity of host '9.205.16.129 (9.205.16.129)' can't be established.
ED25519 key fingerprint is SHA256:5qlUKIQumUor6irsyWcWz8TWGSQLwUFCnA2Axb40P7E.
This key is not known by any other names.
Are you sure you want to continue connecting (yes/no/[fingerprint])? yes
Warning: Permanently added '9.205.16.129' (ED25519) to the list of known hosts.
Welcome to Ubuntu 24.04.4 LTS (GNU/Linux 6.17.0-1008-azure x86_64)

 * Documentation:  https://help.ubuntu.com
 * Management:     https://landscape.canonical.com
 * Support:        https://ubuntu.com/pro

 System information as of Mon Mar 23 09:39:05 UTC 2026

  System load:  0.0               Processes:             114
  Usage of /:   5.7% of 28.02GB   Users logged in:       0
  Memory usage: 31%               IPv4 address for eth0: 10.0.0.4
  Swap usage:   0%

Expanded Security Maintenance for Applications is not enabled.

0 updates can be applied immediately.

Enable ESM Apps to receive additional future security updates.
See https://ubuntu.com/esm or run: sudo pro status


The list of available updates is more than a week old.
To check for new updates run: sudo apt update


The programs included with the Ubuntu system are free software;
the exact distribution terms for each program are described in the
individual files in /usr/share/doc/*/copyright.

Ubuntu comes with ABSOLUTELY NO WARRANTY, to the extent permitted by
applicable law.

To run a command as administrator (user "root"), use "sudo <command>".
See "man sudo_root" for details.

azureuser@tp2:~$ ls
```

## 2. `az` : a programmatic approach
**Créez une VM depuis le Azure CLI**

group create --location denmarkeast --name tp2-rg

 tp2-vm --size Standard_B1s --image almalinux:almalinux-x86_64:10-gen2:10.1.202512150 --admin-username azureuser --ssh-key-value <ta_clé_pub_là>

**Assurez-vous que vous pouvez vous connecter à la VM en SSH sur son IP publique**

joblesstk@fedora:~$ ssh azureuser@9.205.152.231
The authenticity of host '9.205.152.231 (9.205.152.231)' can't be established.
ED25519 key fingerprint is SHA256:6Le12Bov9KeGZcREL17J04GEJ4fT5Hoo/SaZaksdrSY.
This key is not known by any other names.
Are you sure you want to continue connecting (yes/no/[fingerprint])? yes
Warning: Permanently added '9.205.152.231' (ED25519) to the list of known hosts.
[azureuser@tp2-vm ~]$ ls
[azureuser@tp2-vm ~]$ ls -a
.  ..  .bash_logout  .bash_profile  .bashrc  .ssh
[azureuser@tp2-vm ~]$ 


**Une fois connecté, prouvez la présence...**

[azureuser@tp2-vm ~]$ systemctl status waagent.service
● waagent.service - Azure Linux Agent
     Loaded: loaded (/usr/lib/systemd/system/waagent.service; enabled; preset: enabled)
     Active: active (running) since Mon 2026-03-23 10:27:33 UTC; 10min ago
 Invocation: f9edea55047444b1bcef04835485b90a
   Main PID: 1321 (python3)
      Tasks: 6 (limit: 5168)
     Memory: 48.2M (peak: 50.8M)
        CPU: 1.923s
     CGroup: /azure.slice/waagent.service
             ├─1321 /usr/bin/python3 -u /usr/sbin/waagent -daemon
             └─1453 /usr/bin/python3 -u bin/WALinuxAgent-2.15.0.1-py3.12.egg -run-exthandlers

**...du service `cloud-init.service`**

[azureuser@tp2-vm ~]$ systemctl status cloud-init.service
● cloud-init.service - Cloud-init: Network Stage
     Loaded: loaded (/usr/lib/systemd/system/cloud-init.service; enabled; preset: enabled)
     Active: active (exited) since Mon 2026-03-23 10:27:33 UTC; 11min ago
 Invocation: d19b6e36f7b5441586e863765f5c10ff
   Main PID: 945 (code=exited, status=0/SUCCESS)
   Mem peak: 49.9M
        CPU: 793ms

Mar 23 10:27:33 tp2-vm cloud-init[964]: |          *+=o . |
Mar 23 10:27:33 tp2-vm cloud-init[964]: |         o.=B .  |
Mar 23 10:27:33 tp2-vm cloud-init[964]: |       . oo* .   |
Mar 23 10:27:33 tp2-vm cloud-init[964]: |      . S.* o    |
Mar 23 10:27:33 tp2-vm cloud-init[964]: |     .  .ooB     |
Mar 23 10:27:33 tp2-vm cloud-init[964]: |      ..E=O o    |
Mar 23 10:27:33 tp2-vm cloud-init[964]: |       o+@o+.    |
Mar 23 10:27:33 tp2-vm cloud-init[964]: |       .*==o     |
Mar 23 10:27:33 tp2-vm cloud-init[964]: +----[SHA256]-----+
Mar 23 10:27:33 tp2-vm systemd[1]: Finished cloud-init.service - Cloud-init: Network Stage.


## 3. Terraforming ~~planets~~ infrastructures

terraform init

terraform plan

terraform apply

terraform destroy



# TP3A : Terraform + Azure

# I. Network Security Group
terraform apply
```
	Preuve 1
	
	indicated with the following symbols:
  + create

Terraform will perform the following actions:

  # azurerm_linux_virtual_machine.main will be created
  + resource "azurerm_linux_virtual_machine" "main" {
      + admin_username                                         = "azureuser"
      + allow_extension_operations                             = (known after apply)
      + bypass_platform_safety_checks_on_user_schedule_enabled = false
      + computer_name                                          = (known after apply)
      + disable_password_authentication                        = (known after apply)
      + disk_controller_type                                   = (known after apply)
      + extensions_time_budget                                 = "PT1H30M"
      + id                                                     = (known after apply)
      + location                                               = "denmarkeast"
      + max_bid_price                                          = -1
      + name                                                   = "super-vm"
      + network_interface_ids                                  = (known after apply)
      + os_managed_disk_id                                     = (known after apply)
      + patch_assessment_mode                                  = (known after apply)
      + patch_mode                                             = (known after apply)
      + platform_fault_domain                                  = -1
      + priority                                               = "Regular"
      + private_ip_address                                     = (known after apply)
      + private_ip_addresses                                   = (known after apply)
      + provision_vm_agent                                     = (known after apply)
      + public_ip_address                                      = (known after apply)
      + public_ip_addresses                                    = (known after apply)
      + resource_group_name                                    = "tp2-tf-rg"
      + size                                                   = "Standard_B1s"
      + virtual_machine_id                                     = (known after apply)
      + vm_agent_platform_updates_enabled                      = (known after apply)

      + admin_ssh_key {
          + public_key = <<-EOT
                ssh-ed25519 ************************************************************ cloud_tp1_efrei
            EOT
          + username   = "azureuser"
        }

      + os_disk {
          + caching                   = "ReadWrite"
          + disk_size_gb              = (known after apply)
          + id                        = (known after apply)
          + name                      = "vm-os-disk"
          + storage_account_type      = "Standard_LRS"
          + write_accelerator_enabled = false
        }

      + source_image_reference {
          + offer     = "almalinux-x86_64"
          + publisher = "almalinux"
          + sku       = "9-gen2"
          + version   = "latest"
        }

      + termination_notification (known after apply)
    }
```


```
Preuve 2

az>> az vm show -g tp2-tf-rg -n super-vm --show-details -o table
Name      ResourceGroup    PowerState    PublicIps    Fqdns    Location
--------  ---------------  ------------  -----------  -------  -----------
super-vm  tp2-tf-rg        VM running    9.205.155.4           denmarkeast

```
```
Preuve 3

```joblesstk@fedora:~/tp2-terraform$ ssh azureuser@9.205.155.4
The authenticity of host '9.205.155.4 (9.205.155.4)' can't be established.
ED25519 key fingerprint is SHA256:K72RtJmENPla08aLZGMse7oLeylEBFG70OQVKINAyaM.
This key is not known by any other names.
Are you sure you want to continue connecting (yes/no/[fingerprint])? yes
Warning: Permanently added '9.205.155.4' (ED25519) to the list of known hosts.
[azureuser@super-vm ~]$ ls
[azureuser@super-vm ~]$ ls -a
.  ..  .bash_logout  .bash_profile  .bashrc  .ssh
[azureuser@super-vm ~]$ 

```

```
Preuve 4

joblesstk@fedora:~/tp2-terraform$ sudo nano /etc/ssh/sshd_config
[sudo] Mot de passe de joblesstk : 
joblesstk@fedora:~/tp2-terraform$ sudo systemctl restart sshd
joblesstk@fedora:~/tp2-terraform$ ss -tlnp | grep 2222
LISTEN 0      128          0.0.0.0:2222       0.0.0.0:*                                       
LISTEN 0      128             [::]:2222          [::]:*   
```

```
Preuve 5

joblesstk@fedora:~/tp2-terraform$ ssh -p 2222 azureuser@9.205.155.4
Connection closed by 9.205.155.4 port 2222
```


# II. Un ptit nom DNS

