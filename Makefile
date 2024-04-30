COMPOSE := -f docker-compose.yaml
SERVICES          := grafana bettercap elasticsearch logstash nginx

# --------------------------

.PHONY: certs up build pull down stop restart rm logs

certs:		    ## Generate certificates.
	@docker compose -f docker-compose.setup.yaml run --rm certs

setup:			## Generate certificates.
	@make certs

up:				## Build and start all services.
	@docker compose ${COMPOSE} up -d --build ${SERVICES}

build:			## Build all services.
	@docker compose ${COMPOSE} build ${SERVICES}

# username:		## Generate Username (Use only after make up).
# 	@docker compose ${COMPOSE} exec web python3 manage.py createsuperuser

pull:			## Pull Docker images.
	@docker compose ${COMPOSE} pull

down:			## Down all services.
	@docker compose ${COMPOSE} down

stop:			## Stop all services.
	@docker compose ${COMPOSE} stop ${SERVICES}

restart:		## Restart all services.
	@docker compose ${COMPOSE} restart ${SERVICES}

rm:				## Remove all services containers.
	@docker compose $(COMPOSE) rm -f ${SERVICES}

logs:			## Tail all logs with -n 1000.
	@docker compose $(COMPOSE) logs --follow --tail=1000 ${SERVICES}

images:			## Show all Docker images.
	@docker compose $(COMPOSE) images ${SERVICES}
