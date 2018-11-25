# akeneo-scripts
Some scripts to help me to work day to day 

## Import a dump from a duplicated environment

It's very current to download a dump from a duplicated environement in local, to reproduce an issue or analyse a memory leak.

```
git clone git@github.com:ahocquard/akeneo-scripts.git
cd akeneo-scripts

export SERVER_URI=customer-sds.cloud.akeneo.com
export LOCAL_DATABASE_USER=akeneo_pim
export LOCAL_DATABASE_PASSWORD=akeneo_pim
export LOCAL_DATABASE_NAME=akeneo_pim
export LOCAL_DATABASE_PORT=33006
export LOCAL_DATABASE_HOST=127.0.0.1
export PIM_DIRECTORY=/home/akeneo/pim

./import_dump.sh
```

If you have an error to import the dump because Mysql disconnects, execute this command before importing the dump: 

```
SET GLOBAL max_allowed_packet=1073741824;
```
