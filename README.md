# Bettercap-Vision

A *betterview* for bettercap

![demo](https://github.com/Vallsp/bettercap-vision/assets/145016532/40f47f61-fbeb-476b-b267-e3236e6b7180)

## Introduction
Bettercap-Vision provides an easy interface for Bettercap. It combines various components like Logstash, Elasticsearch, Grafana, to create a comprehensive network attack and monitoring solution.

You can easily set up and deploy the entire environment using Docker containers. It allows you to collect Bettercap logs, store them in Elasticsearch, and visualize the data using Grafana.

This tool provides a customizable and user-friendly interface for analyzing network activity and identifying potential security vulnerabilities. It is ideal for security professionals, penetration testers, and network administrators who want to monitor and analyze network traffic in real-time.

The end goal of this project is **not to replace** Bettercap's web interface, but to be complementary of it.

## Benefits
- Easy setup and portability with Docker containers
- Customizable Grafana dashboards for displaying data
- Centralized log storage and analysis
- Enhanced visibility into network security

## Overview

The project is structured to use Docker containers for easy setup and portability. It includes : 

- **Bettercap** for network attacks and monitoring;
- **Logstash** for collecting Bettercap logs;
- **Elasticsearch** for storing the logs:
- **Grafana** for log visualization;
- **Nginx** for the reverse proxying Grafana

![infra](https://github.com/Vallsp/bettercap-vision/assets/145016532/ef6cabf0-8096-4e26-9588-5cb3505ef70f)

### File Structure

- **app folder**: Located at `./app`, this folder contains configuration, such as for provisioning dashboard for Grafana, the Nginx configuration, Logstash config, and Bettercap custom caplets.
- **Dockerfile**: Located at `./certs/Dockerfile`, this file creates a Docker container based on Alpine to generate certificates. It includes the installation of OpenSSL, and it will generate the certificates in `./secrets/certs`.
- **.env.example**: Located at `./env.example`, this example must be copied as `.env`.
- **docker-compose.yaml**: Found in `./docker-compose.yaml`, this Docker Compose file sets up all the containers. (Used by `make up`)
- **docker-compose.setup.yaml**: Found in `./docker-compose.yml`, this Docker Compose file sets up the `certs` container. (Used by `make certs`)
- **Makefile**: Found in `./Makefile`, this Makefile contains all commands available.
- **dashboard.yml**: Located at `./app/grafana-provisioning/dashboards/dashboard.yml`, this configuration file specifies the dashboard provider settings for Grafana.
- **datasources.yml**: Found in `./app/grafana-provisioning/datasources/datasources.yml`, this file configures Grafana to use Elasticsearch, collecting the logs from Logstash.
- **main.conf**: Found in `./app/logstash/pipeline/main.conf`, this file configures Logstash to collect log data from Bettercap REST api.

## Usage

Tested on **Ubuntu 24.04** with native Docker CE. Doesn't work on Windows or macOS for the moment.

To get started with this setup, ensure you have Docker, Docker Compose and make installed on your system. 

Follow these steps to deploy the environment:

1. **Clone this repository**

```
git clone https://github.com/vallsp/bettercap-vision
```

2. **Fill .env**

Copy `.env_example` to `.env`, generate a **strong password** or keep the default passwords (not recommended).
Fill `.env` file with your credentials, and your network interface (ex: eth0).

4. **Generate certs (Required)**

A container will generate certificates for you :

```
make certs
```

4. **Start**
    
Once your certificates are generated, use make to start the containers :

```
make up
```

5. **Accessing Grafana**
Once the containers are up and running, access the Grafana dashboard through your web browser:

```http://localhost:8443```


Use the default Grafana credentials (admin/admin) unless changed in the `.env`. The dashboard should be loaded but there will be likely no data unless Bettercap did some logging.

## Customization and Notes

- The Grafana dashboard and data source configurations can be adjusted in `./app/grafana-provisioning/dashboards/dashboard.yml` and `./app/grafana-provisioning/datasources/datasources.yml` respectively, allowing for further customization of how data is displayed.
- You can add your own dashboards json files in `./app/grafana-provisioning/dashboards`.
- It is possible to go to Bettercap web interface at this address : ```http://localhost:8443```. The default credentials are ```user:pass```.

## IMPORTANT

- Bettercap and Logstash use host networking to communicate with each other. This is because Bettercap does not support custom network interfaces for the REST API. This means that the Bettercap REST API is exposed on the host machine, so be sure to secure it properly. In addition, Elasticsearch has port 9200 exposed for Logstash to send data to it.
- Due to constraints with dashboards, it is not possible to modify the default credentials of Bettercap. The default credentials are ```user:pass```.

## Credits

Thanks to those projects :

- Bettercap : https://github.com/bettercap/bettercap
- Grafana : https://github.com/grafana/grafana
- Logstash : https://github.com/elastic/logstash
- Elasticsearch : https://github.com/elastic/elasticsearch
- Nginx : https://github.com/nginx/nginx
