DOCKER_COMPOSE_FILE		= srcs/docker-compose.yml
DATABASE_VOLUME			= /home/mvan-pee/data/mysql
WORDPRESS_VOLUME		= /home/mvan-pee/data/wordpress
DATABASE_DOCKER_VOLUME	= srcs_mariadb
WORDPRESS_DOCKER_VOLUME	= srcs_wordpress
MKDIR					= mkdir -p
RM						= rm -rf

all:	add-host up

add-host:
	@grep -q "qalpesse.42.fr" /etc/hosts || \
	(echo "🔧 Ajout de qalpesse.42.fr à /etc/hosts..." && \
	echo "127.0.0.1 qalpesse.42.fr" | sudo tee -a /etc/hosts > /dev/null && \
	echo "✅ Domaine ajouté.")

up:
		sudo $(MKDIR) $(DATABASE_VOLUME)
		sudo $(MKDIR) $(WORDPRESS_VOLUME)
		docker-compose -f $(DOCKER_COMPOSE_FILE) up --build -d

down:
		docker-compose -f $(DOCKER_COMPOSE_FILE) down

stop:
		docker-compose -f $(DOCKER_COMPOSE_FILE) stop

clean:		down
		docker container prune --force

fclean:		clean
		sudo $(RM) $(DATABASE_VOLUME)
		sudo $(RM) $(WORDPRESS_VOLUME)
		docker system prune --all --force
		docker volume rm $(DATABASE_DOCKER_VOLUME) $(WORDPRESS_DOCKER_VOLUME)

re:			fclean all

.PHONY:		all volume up down clean fclean re
