
# Mule EE runtime Dockerfile

Docker Image packaging for [Mule EE runtime engine](https://www.mulesoft.com/platform/mule).

*Note: This image is based on the 30-day trial version, unless you are owner of a valid license key.*


### Usage

Example of a Mule runtime using HTTP port 8081 and the following folder mappings:

| Mount point     | Local folder       |
|-----------------|--------------------|
| /opt/mule/apps  | ~/mule/apps        |
| /opt/mule/logs  | ~/mule/logs        |

Now run the following command:
```
docker run -d --name mule382 -p 8081:8081 -v ~/mule/apps:/opt/mule/apps -v ~/mule/logs:/opt/mule/logs rprins/mule-ee-docker
```

#### Important Mule folders

| Location          | Description                                       |
|------------------ |---------------------------------------------------|
|/opt/mule/apps     | Mule Application deployment directory             |
|/opt/mule/domains  | Mule Domains deployment directory                 |
|/opt/mule/logs     | Logs directory                                    |


#### Exposed ports

| Port | Description                                                    |
|----- |----------------------------------------------------------------|
| 8081 | Default HTTP port                                              |


## Providing a license file
*STATUS: TO BE COMPLETED*

This is optional. By default, a 30-day trial period will start after first run.
* Provide the Enterprise license file (mule-ee-license.lic in the same folder as the Dockerfile.
* Build and tag the Docker base image: `docker build --tag="mule-ee"`
* Run the image: `docker run -t -i --name mule382 -p 8081:8081 -v ~/mule/apps:/opt/mule/apps -v ~/mule/logs:/opt/mule/logs mule-ee`


## Setting up a cluster

It is possible to easily set up a cluster with 2 nodes using Docker Compose:
 * Clone repository from [GitHub](https://github.com/rajprins/mule-ee-docker)
 * Navigate to folder `cluster`
 * To launch the cluster and see logs in console, run `docker-compose up`
 * To launch the cluster in detached mode, run `docker-compose up -d`


This will launch two containers, both with a Mule EE runtime, configured to run in a multicast-enabled cluster.

 * Service `mule01`:
    * bind `mule01:8081` to `localhost:8081`
    * mount `/opt/mule/apps` volume to `~/mule/cluster/node1/apps`
    * mount `/opt/mule/logs` volume to `~/mule/cluster/node1/logs`
 * Service `mule02`:
    * bind `mule02:8081` to `localhost:9081`
    * mount `/opt/mule/apps` volume to `~/mule/cluster/node2/apps`
    * mount `/opt/mule/logs` volume to `~/mule/cluster/node2/logs`

Edit `docker-compose.yml` to fit your preferred configuration
