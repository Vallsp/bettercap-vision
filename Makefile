include .env

COMPOSE := -f docker-compose.yaml
SERVICES := grafana bettercap elasticsearch logstash nginx


# --------------------------

.PHONY: certs up build pull down stop restart rm logs

certs:		    ## Generate certificates.
	@sudo docker compose -f docker-compose.setup.yaml run --rm certs

setup:			## Generate certificates.
	@sudo make certs

up:				## Build and start all services.
	@sudo sysctl -w net.ipv4.ip_forward=1
	@sudo iptables -A FORWARD -i ${NETWORK_INTERFACE} -j ACCEPT
	@sudo iptables -A FORWARD -o ${NETWORK_INTERFACE} -j ACCEPT
	@sudo docker compose ${COMPOSE} up -d --build ${SERVICES}

build:			## Build all services.
	@sudo docker compose ${COMPOSE} build ${SERVICES}

pull:			## Pull Docker images.
	@sudo docker compose ${COMPOSE} pull

down:			## Down all services.
	@sudo docker compose ${COMPOSE} down
	@sudo iptables -D FORWARD -i ${NETWORK_INTERFACE} -j ACCEPT
	@sudo iptables -D FORWARD -o ${NETWORK_INTERFACE} -j ACCEPT
	@sudo sysctl -w net.ipv4.ip_forward=0

stop:			## Stop all services.
	@sudo docker compose ${COMPOSE} stop ${SERVICES}

restart:		## Restart all services.
	@sudo docker compose ${COMPOSE} restart ${SERVICES}

rm:				## Remove all services containers.
	@sudo docker compose $(COMPOSE) rm -f ${SERVICES}

logs:			## Tail all logs with -n 1000.
	@sudo docker compose $(COMPOSE) logs --follow --tail=1000 ${SERVICES}

images:			## Show all Docker images.
	@sudo docker compose $(COMPOSE) images ${SERVICES}
