
# Mule EE runtime Dockerfile

Docker Image packaging for [Mule EE runtime engine](https://www.mulesoft.com/platform/mule).

##### Note: This image uses the 30-day trial version of the Mule runtime.


### Usage
Example of a Mule runtime using HTTP port 8081 :

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


## Running multiple instances
If you wish to run multiple Docker containers, for example to set up a load balanced runtime environment, make sure the provide a unique name, mount points and HTTP port mapping for each instance.
Example:

`docker run -d --name mule01 -p 8081:8081 -v ~/mule/mule01/apps:/opt/mule/apps -v ~/mule/mule01/logs:/opt/mule/logs rprins/mule-ee`

`docker run -d --name mule02 -p 8082:8081 -v ~/mule/mule01/apps:/opt/mule/apps -v ~/mule/mule01/logs:/opt/mule/logs rprins/mule-ee`


## Setting up a cluster
It is possible to easily set up a cluster with 2 nodes using Docker Compose:
* Clone repository from [this GitHub location](https://github.com/rajprins/mule-ee-docker)
* Navigate to folder `cluster`
* To launch the cluster and see logs in console, run `docker-compose up`
* To launch the cluster in detached mode, run `docker-compose up -d`


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
