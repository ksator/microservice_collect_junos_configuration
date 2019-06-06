![Docker Cloud Automated build](https://img.shields.io/docker/cloud/automated/ksator/collect-show-commands.svg) ![Docker Cloud Build Status](https://img.shields.io/docker/cloud/build/ksator/collect-show-commands.svg) ![Docker Pulls](https://img.shields.io/docker/pulls/ksator/collect-show-commands.svg) ![MicroBadger Layers (tag)](https://img.shields.io/microbadger/layers/ksator/collect-show-commands/latest.svg)  ![MicroBadger Size (tag)](https://img.shields.io/microbadger/image-size/ksator/collect-show-commands/latest.svg) 
# Description 

This microservice collects Junos show commands  
It uses Ansible. 

# Usage

## Install Docker

## Pull the Docker image
```
$ docker pull ksator/collect-show-commands
```
Verify
```
$ docker images ksator/collect-show-commands
REPOSITORY                     TAG                 IMAGE ID            CREATED             SIZE
ksator/collect-show-commands   latest              bd211df7c333        18 minutes ago      544MB
```

## Create the microservice inputs

Create this structure: 
- An `inputs` directory. With these files: 
  - An Ansible Inventory file (`hosts`) with following variables:
    - `ansible_host`: IP of the device
    - `ansible_ssh_user`: Username to use for the connection
    - `ansible_ssh_pass`: Password to use for the connection
  - A YAML file (`show-commands-to-collect.yml`) to indicate the list of Junos show commands you want to collect       
  
```
$ ls inputs 
hosts  show-commands-to-collect.yml
```

Ansible inventory example: 
```
$ more inputs/hosts
[spines]
demo-qfx10k2-14   ansible_host=172.25.90.67
demo-qfx10k2-15   ansible_host=172.25.90.68

[leaves]
demo-qfx5110-9    ansible_host=172.25.90.63
demo-qfx5110-10   ansible_host=172.25.90.64

[all:vars]
netconf_port=830
ansible_ssh_user=ansible
ansible_ssh_pass=juniper123
```

Configure the details you want to collect. 
Example:   
```
$ more inputs/collector-details.yml

---
cli:
  - "show chassis hardware"
  - "show version"
```


## Run the microservice

This will instanciate a container, execute the service, stop the container and remove the container.    
```
$ docker run -it --rm -v ${PWD}/inputs:/inputs -v ${PWD}/outputs:/outputs ksator/collect-show-commands

Collect Junos show commands

PLAY [collect show commands from devices] *****************************************************************************************************************************************************************************************************************************************

TASK [include_vars] ***************************************************************************************************************************************************************************************************************************************************************
ok: [demo-qfx5110-9]
ok: [demo-qfx5110-10]
ok: [demo-qfx10k2-14]
ok: [demo-qfx10k2-15]

TASK [include_vars] ***************************************************************************************************************************************************************************************************************************************************************
ok: [demo-qfx5110-9]
ok: [demo-qfx5110-10]
ok: [demo-qfx10k2-15]
ok: [demo-qfx10k2-14]

TASK [collect-commands : Create output directory for each device] *****************************************************************************************************************************************************************************************************************
changed: [demo-qfx5110-10]
changed: [demo-qfx10k2-14]
changed: [demo-qfx10k2-15]
changed: [demo-qfx5110-9]

TASK [collect-commands : run the junos show commands and save the output] *********************************************************************************************************************************************************************************************************
ok: [demo-qfx5110-10] => (item=show chassis hardware)
ok: [demo-qfx10k2-14] => (item=show chassis hardware)
ok: [demo-qfx10k2-15] => (item=show chassis hardware)
ok: [demo-qfx5110-9] => (item=show chassis hardware)
ok: [demo-qfx10k2-14] => (item=show version)
ok: [demo-qfx10k2-15] => (item=show version)
ok: [demo-qfx5110-10] => (item=show version)
ok: [demo-qfx5110-9] => (item=show version)

PLAY RECAP ************************************************************************************************************************************************************************************************************************************************************************
demo-qfx10k2-14            : ok=4    changed=1    unreachable=0    failed=0   
demo-qfx10k2-15            : ok=4    changed=1    unreachable=0    failed=0   
demo-qfx5110-10            : ok=4    changed=1    unreachable=0    failed=0   
demo-qfx5110-9             : ok=4    changed=1    unreachable=0    failed=0   

```
List the containers.  
The container doesnt exist anymore
```
$ docker ps
CONTAINER ID        IMAGE               COMMAND             CREATED             STATUS              PORTS               NAMES
```
```
$ docker ps -a
CONTAINER ID        IMAGE               COMMAND             CREATED             STATUS              PORTS               NAMES
```


## Check the microservice output 

Here's the output generated
```
$ tree outputs/
outputs/
├── demo-qfx10k2-14
│   ├── show chassis hardware.txt
│   └── show version.txt
├── demo-qfx10k2-15
│   ├── show chassis hardware.txt
│   └── show version.txt
├── demo-qfx5110-10
│   ├── show chassis hardware.txt
│   └── show version.txt
└── demo-qfx5110-9
    ├── show chassis hardware.txt
    └── show version.txt

4 directories, 8 files
```
```
$ more outputs/demo-qfx5110-9/show\ chassis\ hardware.txt 

Hardware inventory:
Item             Version  Part number  Serial number     Description
Chassis                                WT3718030014      QFX5110-32Q
Pseudo CB 0     
Routing Engine 0          BUILTIN      BUILTIN           RE-QFX5110-32Q
FPC 0            REV 08   650-077245   WT3718030014      QFX5110-32Q
  CPU                     BUILTIN      BUILTIN           FPC CPU
  PIC 0                   BUILTIN      BUILTIN           32x 40G-QSFP
    Xcvr 0       REV 01   740-056705   UUD0N6C           QSFP+40GE-LX4
    Xcvr 1       REV 01   740-056705   UU20A9Z           QSFP+40GE-LX4
    Xcvr 2       REV 01   740-056705   UUC1DWV           QSFP+40GE-LX4
    Xcvr 3       REV 02   740-062254   1AMP23030FX       QSFP+40GE-LX4
    Xcvr 6       REV 01   740-032986   QA520077          QSFP+-40G-SR4
Power Supply 0   REV 04   740-041741   1GA27292724       JPSU-650W-AC-AFO
Power Supply 1   REV 04   740-041741   1GA27292768       JPSU-650W-AC-AFO
Fan Tray 0                                               fan-ctrl-0 0, Front to Back Airflow - AFO
Fan Tray 1                                               fan-ctrl-0 1, Front to Back Airflow - AFO
Fan Tray 2                                               fan-ctrl-1 2, Front to Back Airflow - AFO
Fan Tray 3                                               fan-ctrl-1 3, Front to Back Airflow - AFO
Fan Tray 4                                               fan-ctrl-2 4, Front to Back Airflow - AFO

```
