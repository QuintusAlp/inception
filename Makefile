# Nom du fichier : Makefile

PROJECT_NAME = inception
COMPOSE = docker compose
DC_FILE = ./srcs/compose.yml


.PHONY: up down build start stop restart logs prune fclean re

all: build up

up:
	@$(COMPOSE) -f $(DC_FILE) up -d
	@echo "✅ Infrastructure démarrée"

down:
	@$(COMPOSE) -f $(DC_FILE) down
	@echo "🛑 Infrastructure arrêtée"

build:
	@$(COMPOSE) -f $(DC_FILE) build
	@echo "🔧 Services construits"

start:
	@$(COMPOSE) -f $(DC_FILE) start
	@echo "▶️ Services démarrés"

stop:
	@$(COMPOSE) -f $(DC_FILE) stop
	@echo "⏸️ Services stoppés"

restart:
	@$(MAKE) stop
	@$(MAKE) start
	@echo "🔁 Redémarrage terminé"

logs:
	@$(COMPOSE) -f $(DC_FILE) logs -f

prune:
	@docker system prune -f
	@echo "🧹 Docker nettoyé"

fclean: down
	@docker volume rm $$(docker volume ls -qf "name=$(PROJECT_NAME)_") 2>/dev/null || true
	@docker image prune -af
	@echo "🧼 Tout a été nettoyé"

re: fclean build up
	@echo "♻️ Projet reconstruit depuis zéro"
