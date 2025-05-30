DC_FILE = ./srcs/compose.yml
DC = sudo docker compose -f $(DC_FILE)
DOMAIN_NAME = qalpesse.42.fr
IP_ADDRESS = 127.0.0.1
HOSTS_LINE = $(IP_ADDRESS)\t$(DOMAIN_NAME)
VOLUME_PATH1 = /home/qalpesse/data/mysql
VOLUME_PATH2 = /home/qalpesse/data/wordpress

.PHONY: up down build restart logs ps all

all : add-host v_dir build up

add-host:
	@if ! grep -q "$(DOMAIN_NAME)" /etc/hosts; then \
		echo "Ajout de $(DOMAIN_NAME) à /etc/hosts"; \
		echo "$(HOSTS_LINE)" | sudo tee -a /etc/hosts > /dev/null; \
	else \
		echo "$(DOMAIN_NAME) existe déjà dans /etc/hosts"; \
	fi
v_dir:
	sudo mkdir -p $(VOLUME_PATH1)
	sudo mkdir -p $(VOLUME_PATH2)
	sudo chmod 777 $(VOLUME_PATH1)
	sudo chmod 777 $(VOLUME_PATH2)
up:
	@echo "🚀 Démarrage des conteneurs en arrière-plan..."
	$(DC) up -d
	@echo "✅ Conteneurs démarrés avec succès !"

down:
	@echo "🛑 Arrêt et suppression des conteneurs, réseaux et volumes..."
	$(DC) down
	@echo "🧹 Infrastructure arrêtée et nettoyée !"

build:
	@echo "🔨 Construction (ou reconstruction) des images Docker..."
	$(DC) build
	@echo "🏗️ Images construites avec succès !"

restart:
	@echo "♻️ Redémarrage des conteneurs..."
	$(DC) restart
	@echo "🔄 Conteneurs redémarrés !"

logs:
	@echo "📜 Affichage des logs en temps réel (Ctrl+C pour quitter)..."
	$(DC) logs -f

ps:
	@echo "📊 État des conteneurs Docker en cours d'exécution :"
	$(DC) ps
clean:
	$(DC) down --volumes --remove-orphans --rmi all

fclean: clean
	@echo "🧨 Nettoyage complet : suppression des conteneurs, réseaux, volumes Docker..."
	sudo rm -rf $(VOLUME_PATH1)
	sudo rm -rf $(VOLUME_PATH2)
	@echo "🚿 Infrastructure Docker complètement nettoyée !"
re : fclean all
