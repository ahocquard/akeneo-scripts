#!/bin/bash

ssh akeneo@${SERVER_URI} <<'COMMAND'

export DATABASE_PASSWORD=$(cat /home/akeneo/pim/app/config/parameters.yml | grep database_password | sed 's/database_password://g' | tr -d ' ')
mysqldump -u akeneo_pim -p${DATABASE_PASSWORD} --quick akeneo_pim | gzip >/var/tmp/dump.sql.gz
COMMAND

scp akeneo@${SERVER_URI}:/var/tmp/dump.sql.gz /var/tmp/dump.sql.gz

gunzip < /var/tmp/dump.sql.gz | mysql -u ${LOCAL_DATABASE_USER} -p${LOCAL_DATABASE_PASSWORD} ${LOCAL_DATABASE_NAME}
cd ${PIM_DIRECTORY}
bin/console akeneo:elasticsearch:reset-indexes
bin/console pim:product-model:index --all
bin/console pim:product:index --all
