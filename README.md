# Bettercap-Vision

A *betterview* for bettercap

![image](https://github.com/Vallsp/bettercap-vision/assets/145016532/40f47f61-fbeb-476b-b267-e3236e6b7180)

## Overview

The project is structured to use Docker containers for easy setup and portability. It includes : 

- **Bettercap** for network attacks and monitoring;
- **Logstash** for collecting Bettercap logs;
- **Elasticsearch** for storing the logs:
- **Grafana** for log visualization;
- **Nginx** for the reverse proxying Grafana

![infra](https://github.com/Vallsp/bettercap-vision/assets/145016532/4008b56e-15c8-4f53-818e-f0b4f874c845)

### File Structure

- **app folder**: Located at `./app`, this folder contains configuration, such as for provisioning dashboard for Grafana, the Nginx configuration, Logstash config, and Bettercap custom caplets.
- **Dockerfile**: Located at `./certs/Dockerfile`, this file creates a Docker container based on Alpine to generate certificates. It includes the installation of OpenSSL, and it will generate the certificates in `./secrets/certs`.
- **.env_example**: Located at `./env`, this example must be copied as `.env`.
- **docker-compose.yaml**: Found in `./docker-compose.yml`, this Docker Compose file sets up all the containers. (Used by `make up`)
- **docker-compose.setup.yaml**: Found in `./docker-compose.yml`, this Docker Compose file sets up the `certs` container. (Used by `make certs`)
- **Makefile**: Found in `./Makefile`, this Makefile contains all commands available.
- **dashboard.yml**: Located at `./app/grafana-provisioning/dashboards/dashboard.yml`, this configuration file specifies the dashboard provider settings for Grafana.
- **datasources.yml**: Found in `./app/grafana-provisioning/datasources/datasources.yml`, this file configures Grafana to use Elasticsearch, collecting the logs from Logstash.
- **main.conf**: Found in `./app/logstash/pipeline/main.conf`, this file configures Logstash to collect log data from Bettercap REST api.

## Usage

To get started with this setup, ensure you have Docker, Docker Compose and make installed on your system. 

Follow these steps to deploy the environment:

1. **Clone this repository**

```
git clone https://github.com/vallsp/bettercap-vision
```

2. **Generate certs**
**Required**

A container will generate certificates for you :

```
make certs
```

3. **Start**
    
Once your certificates are generated, use make to start the containers :

```
make up
```

4. **Accessing Grafana**
Once the containers are up and running, access the Grafana dashboard through your web browser:

```http://localhost```

Use the default Grafana credentials (admin/admin) unless changed in the `.env`. The dashboard should be loaded but there will be likely no data unless Bettercap did some logging.

## Customization and Notes

- The Grafana dashboard and data source configurations can be adjusted in `./app/grafana-provisioning/dashboards/dashboard.yml` and `./app/grafana-provisioning/datasources/datasources.yml` respectively, allowing for further customization of how data is displayed.
- You can add your own dashboards json files in `./app/grafana-provisioning/dashboards`.

## Credits

Thanks to those projects :

- Bettercap : https://github.com/bettercap/bettercap
- Grafana : https://github.com/grafana/grafana
- Logstash : https://github.com/elastic/logstash
- Elasticsearch : https://github.com/elastic/elasticsearch
- Nginx : https://github.com/nginx/nginx
