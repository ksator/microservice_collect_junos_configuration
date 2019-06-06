# Description 

This microservice collects Junos configuration    
It uses Ansible. 

# Usage

## Install Docker

## Pull the Docker image
```
$ docker pull ksator/collect-junos-configuration


```
Verify
```
$ docker images ksator/collect-junos-configuration

```

## Create the microservice inputs

Create this structure: 
- An `inputs` directory. With these files: 
  - An Ansible Inventory file (`hosts`) with following variables:
    - `ansible_host`: IP of the device
    - `ansible_ssh_user`: Username to use for the connection
    - `ansible_ssh_pass`: Password to use for the connection
  - A YAML file (`configuration_format_to_collect.yml`) to indicate the desired format for the Junos configuration (text, json, xml, set). The default format is text.         
  
```
$ ls inputs 
hosts  configuration_format_to_collect.yml
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

Configure the desired format for the Junos configuration (text, json, xml, set)   
Example:   
```
$ more inputs/configuration_format_to_collect.yml

---
configuration:
  format: text

```


## Run the microservice

This will instanciate a container, execute the service, stop the container and remove the container.    
```
$ docker run -it --rm -v ${PWD}/inputs:/inputs -v ${PWD}/outputs:/outputs ksator/collect-junos-configuration


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
```
```
$ more outputs/demo-qfx5110-9/
```
