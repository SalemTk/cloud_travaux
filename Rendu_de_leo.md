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
 Invocation: ****************************
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
 Invocation: *********************************
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
                ssh-ed25519 +++++++++++++++++++++++++++++++++++++++++ cloud_tp1_efrei
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

```
resource "azurerm_public_ip" "main" { name = "vm-ip" location = azurerm_resource_group.main.location resource_group_name = azurerm_resource_group.main.name allocation_method = "Static" sku = "Standard" domain_name_label = "tp2-vm-salem" }
```

output "public_ip" { value = azurerm_public_ip.main.ip_address } output "dns_name" { value = azurerm_public_ip.main.fqdn } 
``` ### 3. Sortie du `terraform apply` 
```azurerm_resource_group.main: Refreshing state... [id=/subscriptions/0c70738f-7302-47b3-b01e-05e58f452b7d/resourceGroups/tp2-tf-rg]
azurerm_public_ip.main: Refreshing state... [id=/subscriptions/0c70738f-7302-47b3-b01e-05e58f452b7d/resourceGroups/tp2-tf-rg/providers/Microsoft.Network/publicIPAddresses/vm-ip]
azurerm_virtual_network.main: Refreshing state... [id=/subscriptions/0c70738f-7302-47b3-b01e-05e58f452b7d/resourceGroups/tp2-tf-rg/providers/Microsoft.Network/virtualNetworks/vm-vnet]
azurerm_network_security_group.main: Refreshing state... [id=/subscriptions/0c70738f-7302-47b3-b01e-05e58f452b7d/resourceGroups/tp2-tf-rg/providers/Microsoft.Network/networkSecurityGroups/vm-nsg]
azurerm_subnet.main: Refreshing state... [id=/subscriptions/0c70738f-7302-47b3-b01e-05e58f452b7d/resourceGroups/tp2-tf-rg/providers/Microsoft.Network/virtualNetworks/vm-vnet/subnets/vm-subnet]
azurerm_network_interface.main: Refreshing state... [id=/subscriptions/0c70738f-7302-47b3-b01e-05e58f452b7d/resourceGroups/tp2-tf-rg/providers/Microsoft.Network/networkInterfaces/vm-nic]
azurerm_network_interface_security_group_association.main: Refreshing state... [id=/subscriptions/0c70738f-7302-47b3-b01e-05e58f452b7d/resourceGroups/tp2-tf-rg/providers/Microsoft.Network/networkInterfaces/vm-nic|/subscriptions/0c70738f-7302-47b3-b01e-05e58f452b7d/resourceGroups/tp2-tf-rg/providers/Microsoft.Network/networkSecurityGroups/vm-nsg]
	
```


output.tf >
output "public_ip" { value = azurerm_public_ip.main.ip_address } output "dns_name" { value = azurerm_public_ip.main.fqdn }

dns_name = "tp2-vm-salem.denmarkeast.cloudapp.azure.com"
public_ip = "9.205.154.144"


# III. Blob storage

```joblesstk@fedora:~/tp2-terraform$ ssh azureuser@tp2-vm-salem.denmarkeast.cloudapp.azure.com
The authenticity of host 'tp2-vm-salem.denmarkeast.cloudapp.azure.com (9.205.154.144)' can't be established.
ED25519 key fingerprint is SHA256:EdGQajSFyVi8GAYBZMduEnau6FyyzGtX1B1DtFrRWYc.
This key is not known by any other names.
Are you sure you want to continue connecting (yes/no/[fingerprint])? yes
Warning: Permanently added 'tp2-vm-salem.denmarkeast.cloudapp.azure.com' (ED25519) to the list of known hosts.
[azureuser@super-vm ~]$ ls
```

```[azureuser@super-vm azcopy_linux_amd64_10.32.2]$ azcopy login --identity
INFO: Login with identity succeeded.
```

```
ssh azureuser@tp2-vm-salem.denmarkeast.cloudapp.azure.com
curl -L https://aka.ms/downloadazcopy-v10-linux -o azcopy.tar.gz
tar -xvf azcopy.tar.gz
sudo mv ./azcopy_linux_amd64_*/azcopy /usr/local/bin/
azcopy login --identity
echo "hello blob storage" > test.txt
azcopy copy test.txt "https://tp2storagesalem.blob.core.windows.net/tp2-container/test.txt"
azcopy copy "https://tp2storagesalem.blob.core.windows.net/tp2-container/test.txt" test_download.txt
cat test_download.txt
```

> `azcopy login --identity` utilise la **Managed Identity** (identité managée) attachée à la VM. Concrètement, la VM contacte le service de métadonnées Azure sur `169.254.169.254` pour obtenir un **JWT (JSON Web Token)**. Ce token prouve l'identité de la VM auprès d'Azure AD, sans aucun mot de passe ni secret à stocker.

```
curl -s -H "Metadata:true" "http://169.254.169.254/metadata/identity/oauth2/token?api-version=2018-02-01&resource=https://storage.azure.com/" | python3 -m json.tool
```

> La commande `curl` contacte l'**IMDS (Instance Metadata Service)** d'Azure sur `169.254.169.254`. Ce service retourne un **JWT (JSON Web Token)** qui contient :
> 
> - `access_token` : le token JWT signé par Azure AD
> - `expires_on` : date d'expiration du token
> - `resource` : la ressource pour laquelle le token est valide (ici le Blob Storage)
> - `token_type` : `Bearer`
> 
> C'est exactement ce token que `azcopy login --identity` récupère automatiquement en arrière-plan pour s'authentifier auprès du Blob Storage, sans aucun mot de passe !


```
`169.254.169.254` est une adresse **link-local** (plage `169.254.0.0/16`). Azure injecte une route statique dans la table de routage de la VM qui pointe vers cette IP
```

```
[azureuser@super-vm azcopy_linux_amd64_10.32.2]$ ip route show
default via 10.0.1.1 dev eth0 proto dhcp src 10.0.1.4 metric 100 
10.0.1.0/24 dev eth0 proto kernel scope link src 10.0.1.4 metric 100 
168.63.129.16 via 10.0.1.1 dev eth0 proto dhcp src 10.0.1.4 metric 100 
169.254.169.254 via 10.0.1.1 dev eth0 proto dhcp src 10.0.1.4 metric 100 

```

```
> 	L'IP `169.254.169.254` est joignable car Azure **injecte automatiquement une route statique via DHCP** dans la table de routage de la VM. Cette route pointe vers le routeur `10.0.1.1` qui sait rediriger le trafic vers le service de métadonnées Azure (IMDS - Instance Metadata Service). C'est Azure qui gère tout ça de façon transparente, la VM n'a rien à configurer manuellement.
```


# IV. Monitoring

```
az>> az monitor metrics alert list -g tp2-tf-rg -o table
AutoMitigate    Description                                 Enabled    EvaluationFrequency    Location    Name                ResourceGroup    Severity    TargetResourceRegion    TargetResourceType    WindowSize
--------------  ------------------------------------------  ---------  ---------------------  ----------  ------------------  ---------------  ----------  ----------------------  --------------------  ------------
True            Alert when CPU usage exceeds 70%            True       PT1M                   global      cpu-alert-super-vm  tp2-tf-rg        2                                                         PT5M
True            Alert when available memory is below 512MB  True       PT1M                   global      ram-alert-super-vm  tp2-tf-rg        2                                                         PT5M

```

> "J'ai reçu les mails d'alerte pour le CPU et la RAM"

```
d7f3986c-f6c5-4d4e-a028-3dceccd7e402  00c90ce0-9805-53c4-cbd3-b3c7b957c2f4                 dcbfc1d8-ac6b-4ec6-bff8-0c39bfdc3eb0  2026-03-24T08:31:21.2435665Z  Informational  363303e7-84c5-4f83-9cf7-447c9e099b11  tp2-tf-rg        tp2-tf-rg            /subscriptions/0c70738f-7302-47b3-b01e-05e58f452b7d/resourceGroups/tp2-tf-rg/providers/Microsoft.Insights/metricAlerts/cpu-alert-super-vm                                                                                        2026-03-24T08:33:00Z   0c70738f-7302-47b3-b01e-05e58f452b7d  4bc9797c-487f-47a9-aaf2-7b10b0f37aab
d7f3986c-f6c5-4d4e-a028-3dceccd7e402  00c90ce0-9805-53c4-cbd3-b3c7b957c2f4                 4cd159e0-cd9e-4e99-b7a3-e6c29c4892cc  2026-03-24T08:31:12.9780592Z  Informational  363303e7-84c5-4f83-9cf7-447c9e099b11  tp2-tf-rg        tp2-tf-rg            /subscriptions/0c70738f-7302-47b3-b01e-05e58f452b7d/resourceGroups/tp2-tf-rg/providers/Microsoft.Insights/metricAlerts/cpu-alert-super-vm                                                                                        2026-03-24T08:33:00Z   0c70738f-7302-47b3-b01e-05e58f452b7d  4bc9797c-487f-47a9-aaf2-7b10b0f37aab
d7f3986c-f6c5-4d4e-a028-3dceccd7e402  00c90ce0-9805-53c4-cbd3-b3c7b957c2f4                 3d7aca61-67cb-4696-b424-19496ac4d31e  2026-03-24T08:31:12.9780332Z  Informational  9cb2b7a2-fcc6-4606-bf02-aa513a13ae45  tp2-tf-rg        tp2-tf-rg            /subscriptions/0c70738f-7302-47b3-b01e-05e58f452b7d/resourceGroups/tp2-tf-rg/providers/Microsoft.Insights/metricAlerts/ram-alert-super-vm                                                                                        2026-03-24T08:32:45Z   0c70738f-7302-47b3-b01e-05e58f452b7d  4bc9797c-487f-47a9-aaf2-7b10b0f37aab
d7f3986c-f6c5-4d4e-a028-3dceccd7e402  00c90ce0-9805-53c4-cbd3-b3c7b957c2f4                 66a2ae22-78aa-4dfd-a188-81a48c9e6d6d  2026-03-24T08:31:11.5944409Z  Informational  e64d7f1a-7ea9-4cc5-a42f-d6d00f5dc1d6  tp2-tf-rg        tp2-tf-rg            /subscriptions/0c70738f-7302-47b3-b01e-05e58f452b7d/resourceGroups/tp2-tf-rg/providers/Microsoft.Insights/actionGroups/ag-tp2-tf-rg-alerts                                                                                       2026-03-24T08:32:49Z   0c70738f-7302-47b3-b01e-05e58f452b7d  4bc9797c-487f-47a9-aaf2-7b10b0f37aab
d7f3986c-f6c5-4d4e-a028-3dceccd7e402  00c90ce0-9805-53c4-cbd3-b3c7b957c2f4                 662be20e-2a27-4de8-a53d-482b1bef6d52  2026-03-24T08:31:10.0631816Z  Informational  e64d7f1a-7ea9-4cc5-a42f-d6d00f5dc1d6  tp2-tf-rg        tp2-tf-rg            /subscriptions/0c70738f-7302-47b3-b01e-05e58f452b7d/resourceGroups/tp2-tf-rg/providers/Microsoft.Insights/actionGroups/ag-tp2-tf-rg-alerts                                                                                       2026-03-24T08:32:49Z   0c70738f-7302-47b3-b01e-05e58f452b7d  4bc9797c-487f-47a9-aaf2-7b10b0f37aab

```

```
[azureuser@super-vm azcopy_linux_amd64_10.32.2]$ stress-ng --cpu 4 --timeout 600s
stress-ng: info:  [10769] setting to a 10 mins run per stressor
stress-ng: info:  [10769] dispatching hogs: 4 cpu
stress-ng: info:  [10769] note: system has only 270 MB of free memory and swap, recommend using --oom-avoid
^Cstress-ng: info:  [10769] skipped: 0
stress-ng: info:  [10769] passed: 4: cpu (4)
stress-ng: info:  [10769] failed: 0
stress-ng: info:  [10769] metrics untrustworthy: 0
stress-ng: info:  [10769] successful run completed in 9 mins, 32.85 secs
[azureuser@super-vm azcopy_linux_amd64_10.32.2]$ stress-ng --vm 2 --vm-bytes 400M --timeout 600s
stress-ng: info:  [11182] setting to a 10 mins run per stressor
stress-ng: info:  [11182] dispatching hogs: 2 vm
stress-ng: info:  [11182] note: system has only 280 MB of free memory and swap, recommend using --oom-avoid
stress-ng: info:  [11182] skipped: 0
stress-ng: info:  [11182] passed: 2: vm (2)
stress-ng: info:  [11182] failed: 0
stress-ng: info:  [11182] metrics untrustworthy: 0
stress-ng: info:  [11182] successful run completed in 10 mins
[azureuser@super-vm azcopy_linux_amd64_10.32.2]$ 

```


# V. Azure Vault


```
az>> az keyvault secret show --name "tp2-secret" --vault-name "tp2-keyvault-salem" --query "value" -o tsv
*******************************

```

```
[azureuser@super-vm azcopy_linux_amd64_10.32.2]$ TOKEN=$(curl -s -H "Metadata:true" \
  "http://169.254.169.254/metadata/identity/oauth2/token?api-version=2018-02-01&resource=https://vault.azure.net" \
  | python3 -c "import sys,json; print(json.load(sys.stdin)['access_token'])")
[azureuser@super-vm azcopy_linux_amd64_10.32.2]$ curl -s -H "Authorization: Bearer $TOKEN" \
  "https://tp2-keyvault-salem.vault.azure.net/secrets/tp2-secret?api-version=7.0" \
  | python3 -m json.tool
{
    "value": "***********************",
    "contentType": "",
    "id": "https://tp2-keyvault-salem.vault.azure.net/secrets/tp2-secret/************",
    "attributes": {
        "enabled": true,
        "created": 1774344316,
        "updated": 1774344316,
        "recoveryLevel": "Recoverable+Purgeable"
    },
    "tags": {}
}

```

