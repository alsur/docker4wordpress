#docker dump exec para pasar al init. Vo1
#asume que se ejecuta desde /etc
docker exec -i {{PROJECT_NAME}}_mariadb mysqldump -u{{DB_USER}} -p{{DB_PASSWORD}} --databases {{DB_NAME}} --skip-comments > ../docker.d/mysql-init/init.sql