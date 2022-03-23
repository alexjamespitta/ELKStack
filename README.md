# ELKStack
ELKStack using filebeat and metricbeat

# Automated ELK Stack Deployment

The files in this repository were used to configure the network depicted below.

![ELKDiagram](https://user-images.githubusercontent.com/93354303/159599020-f5646bd3-8820-4459-bc0d-ac02e2390cab.jpg)

These files have been tested and used to generate a live ELK deployment on Azure. They can be used to either recreate the entire deployment pictured above. Alternatively, select portions of the ELKStack file may be used to install only certain pieces of it, such as Filebeat.

  -[Playbooks copy.zip](https://github.com/alexjamespitta/ELKStack/files/8328700/Playbooks.copy.zip)


This document contains the following details:
- Description of the Topology
- Access Policies
- ELK Configuration
  - Beats in Use
  - Machines Being Monitored
- How to Use the Ansible Build


### Description of the Topology

The main purpose of this network is to expose a load-balanced and monitored instance of DVWA, the D*mn Vulnerable Web Application.

Load balancing ensures that the application will be highly reliable and available, in addition to restricting traffic to the network.
- Load balancing plays a vital role in network security as the off-loading function helps defend against distributed denial-of-service attacks.
- The advantage of using a jumpbox is that it is a highly-secured computer that is only used for administrative tasks and to manage devices in a separate security zone.  Due to network security configuration, only the jumpbox is allowed to connect and administer to the connected web servers, and with the use of ansible it is easy to manage and configure multiple web servers unanimously and simultaneously.  

Integrating an ELK server allows users to easily monitor the vulnerable VMs for changes to the data and system logs.
- Filebeat monitors specified log files and locations and forwards log events for further analysis.    
- Metricbeat forwards metrics and statistics and facilitates monitoring of systems and services on a server. 

The configuration details of each machine may be found below.

| Name                 | Function   | IP Address                              | Operating System     |
|----------------------|------------|-----------------------------------------|----------------------|
| Jump-Box-Provisioner | Gateway    | Public: 52.255.149.69 Private: 10.1.0.4 | Linux (Ubuntu 18.04) |
| Elk                  | Analytics  | Public: 20.96.32.76 Private: 10.0.0.4   | Linux (Ubuntu 18.04) |
| Web-1                | Web Server | Public: 40.85.170.133 Private: 10.1.0.6 | Linux (Ubuntu 18.04) |
| Web-2                | Web Server | Public: 40.85.170.133 Private: 10.1.0.7 | Linux (Ubuntu 18.04) |
| Web-3                | Web Server | Public: 40.85.170.133 Private: 10.1.0.8 | Linux (Ubuntu 18.04) |

### Access Policies

The machines on the internal network are not exposed to the public Internet. 

Only the Jump-Box-Provisioner machine can accept connections from the Internet. Access to this machine is only allowed from the following IP addresses:
- 104.176.79.52

Machines within the network can only be accessed by root@a27eb66c652d in the ansible container on Jump-Box-Provisioner.
- SSH to Elk is allowed by 104.176.79.52 with private key provided by root@a27eb66c652d in the ansible container on Jump-Box-Provisioner. 

A summary of the access policies in place can be found in the table below.

| Name                 | Publicly Accessible | AllowedIP Address                     |
|----------------------|---------------------|---------------------------------------|
| Jump-Box-Provisioner | no                  | 104.176.79.52 10.1.0.0/16 10.0.0.0/16 |
| Elk                  | no                  | 104.176.79.52 10.1.0.0/16 10.0.0.0/16 |
| Web-1                | no                  | 104.176.79.52 10.1.0.0/16 10.0.0.0/16 |
| Web-2                | no                  | 104.176.79.52 10.1.0.0/16 10.0.0.0/16 |
| Web-3                | no                  | 104.176.79.52 10.1.0.0/16 10.0.0.0/16 |

### Elk Configuration

Ansible was used to automate configuration of the ELK machine. No configuration was performed manually, which is advantageous because...
-All configurations can be deployed uniformly and simultaneously.  

The playbook implements the following tasks:

- install-elk.yml
	- install docker.io
	- install python3
	- install docker python module
	- configure memory to 262144
	- download and launch ELK docker web container

- filebeat-playbook.yml
	- download deb from artifacts.elastic.co
	- install filebeat
	- enable and configure filebeat docker
	- filebeat setup
	- filebeat start
	- enable filebeat on boot

- metricbeat-playbook.yml
	- download deb from artifacts.elastic.co
	- install metricbeat
	- drop in metric beat config
	- enable and configure metricbeat docker
	- metricbeat setup
	- metricbeat start
	- Enable metricbeat on boot


The following screenshot displays the result of running `docker ps` after successfully configuring the ELK instance.

![/READM![docker_ps_output](https://user-images.githubusercontent.com/93354303/159599148-a15850bd-2864-4ce8-ab12-120ec02f801d.png)
E/Images/docker_ps_output.png]

### Target Machines & Beats
This ELK server is configured to monitor the following machines:
- 10.1.0.6
- 10.1.0.7
- 10.1.0.8

We have installed the following Beats on these machines:
- Metricbeat
- Filebeat

These Beats allow us to collect the following information from each machine:

- Metricbeat collects metrics from the operating system and services running on a container to be monitored.  Different metric sets that can be monitored are cpu, load, memory, process, network, etc.  
- Filebeat forwards and centralizes log data.  It monitors log files and specified locations, collects log events, and forwards them for indexing and analysis.  Filebeat handles audit logs, deprecation logs, gc logs, server logs, slow logs, etc. 

### Using the Playbook
In order to use the playbook, you will need to have an Ansible control node already configured. Assuming you have such a control node provisioned: 

SSH into the control node and follow the steps below:
- Copy the configuration file to Virtual Machine by running the playbook using: ansible-playbook install-elk.yml.
- Update the configuration file to include host IP address and port
- Run the playbook, and navigate to http://20.96.32.76:5601/ (ELK IP and associated port) to check that the installation worked as expected.
