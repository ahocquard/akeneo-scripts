#!/bin/bash

ssh akeneo@${SERVER_URI} <<'COMMAND'
export DATABASE_PASSWORD=$(cat /home/akeneo/pim/app/config/parameters.yml | grep database_password | sed 's/database_password://g' | tr -d ' ')
mysqldump --ignore-table=akeneo_pim.pim_versioning_version --ignore-table=akeneo_pim.akeneo_batch_warning -u akeneo_pim -p${DATABASE_PASSWORD} --quick akeneo_pim | gzip >/var/tmp/dump.sql.gz
COMMAND

scp akeneo@${SERVER_URI}:/var/tmp/dump.sql.gz /var/tmp/dump.sql.gz

gunzip < /var/tmp/dump.sql.gz | mysql -u ${LOCAL_DATABASE_USER} -p${LOCAL_DATABASE_PASSWORD} ${LOCAL_DATABASE_NAME} -P ${LOCAL_DATABASE_PORT} -h ${LOCAL_DATABASE_HOST}
cd ${PIM_DIRECTORY}
docker-compose exec fpm bin/console akeneo:elasticsearch:reset-indexes -e prod
docker-compose exec fpm bin/console pim:product-model:index --all -e prod
docker-compose exec fpm bin/console pim:product:index --all -e prod
