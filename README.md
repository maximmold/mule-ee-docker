
# Docker Image packaging for [Mule](https://www.mulesoft.com/platform/mule)  EE runtime engine

##### Note: This image uses the 30-day trial version of the Mule runtime.


### Usage
Example of starting the container with Mule EE runtime, using HTTP port 8081 and mapped mount points:

```
docker run -d --name mule382 -p 8081:8081 -v ~/mule/apps:/opt/mule/apps -v ~/mule/logs:/opt/mule/logs rprins/mule-ee
```

#### Relevant Mule folders and mappings
| Location          | Description                            | Local folder mapping |
|------------------ |----------------------------------------|----------------------|
|/opt/mule/apps     | Mule Application deployment directory  | ~/mule/apps          |
|/opt/mule/domains  | Mule Domains deployment directory      | |
|/opt/mule/logs     | Logs directory                         | ~/mule/logs          |


#### Exposed ports
| Port | Description                                                    |
|----- |----------------------------------------------------------------|
| 8081 | Default port for HTTP inbound endpoints                        |


## Deploying applications
The simplest way of deploying Mule applications is to copy a deployable archive (.zip file, created with Anypoint Studio or Maven) to the mapped ~/mule/apps folder.

Alternatively, you can install the Mule Agent and register your Mule runtime with the Anypoint Runtime Manager. Details can be found [here](https://docs.mulesoft.com/runtime-manager/managing-servers#add-a-server). Now you can use the Anypoint Runtime Manager to deploy and monitor Mule applications.


## Connecting to a running container
To connect to a running container, you can open a Bash shell
* First, retrieve the container's ID: `docker ps`
* Check the CONTAINER_ID column of the output
* Open a Bash shell on the container: `docker exec -t -i <CONTAINER_ID> /bin/bash`



## Running multiple instances
If you wish to run multiple Docker containers, for example to set up a load balanced runtime environment, make sure the provide a unique name, mount points and HTTP port mapping for each instance.
Example:

`docker run -d --name mule01 -p 8081:8081 -v ~/mule/mule01/apps:/opt/mule/apps -v ~/mule/mule01/logs:/opt/mule/logs rprins/mule-ee`

`docker run -d --name mule02 -p 8082:8081 -v ~/mule/mule01/apps:/opt/mule/apps -v ~/mule/mule01/logs:/opt/mule/logs rprins/mule-ee`


## Setting up a cluster
It is possible to set up a cluster with 2 nodes using Docker Compose:
* Clone [this](https://github.com/rajprins/mule-ee-docker) GitHub repository: `git clone https://github.com/rajprins/mule-ee-docker.git`
* From the location where you cloned the GitHub repo files, navigate to folder `cluster`
* To launch the cluster and see logs in console, run `docker-compose up`



This will launch two containers, both with a Mule EE runtime, configured to run in a multicast-enabled cluster.
* Service `mule01`:
  * bind `mule01:8081` to `localhost:8081`
  * mount `/opt/mule/apps` volume to `~/mule/cluster/mule01/apps`
  * mount `/opt/mule/logs` volume to `~/mule/cluster/mule01/logs`
* Service `mule02`:
  * bind `mule02:8081` to `localhost:9081`
  * mount `/opt/mule/apps` volume to `~/mule/cluster/mule02/apps`
  * mount `/opt/mule/logs` volume to `~/mule/cluster/mule02/logs`

Edit `docker-compose.yml` to fit your preferred configuration
