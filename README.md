# akeneo-scripts
Some scripts to help me to work day to day 

## Import a dump from a duplicated environment

It's very current to download a dump and install it in

```
git clone git@github.com:ahocquard/akeneo-scripts.git
cd akeneo-scripts

export SERVER_URI=customer-sds.cloud.akeneo.com
export LOCAL_DATABASE_USER=akeneo_pim
export LOCAL_DATABASE_PASSWORD=akeneo_pim
export LOCAL_DATABASE_NAME=akeneo_pim
export PIM_DIRECTORY=/home/akeneo/pim

./import_dump.sh
```
