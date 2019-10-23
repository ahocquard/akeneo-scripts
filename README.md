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

## Create body to profile API product import

```
curl -X GET \                
  'http://localhost:8080/api/rest/v1/products?limit=100' \
  -H 'Authorization: Bearer NjJmZTVhNGQ3NjVlZWE1MzhhOWUwMWFmM2M3YWM3OTAyNDk4NjVhNzQyYjljZDUyZmY1YTA1ZGMzMjI4MmI1Yg' | tac | tac | php ./api.php > body.txt
```

then:

```
docker-compose run -u www-data --rm php blackfire curl -X PATCH http://httpd/api/rest/v1/products -H 'authorization: Bearer NWM5Mzg0MWE0YjE2MGJlM2JmNGIxY2QxMjRlMTNkYjUzMDU4NDhjNzNlMWNjMWMyZmMwZGZhNTkxZjlkZTUxYw'  -H 'cache-control: no-cache' -H 'content-type: application/vnd.akeneo.collection+json' --data-binary '@body.txt'
```
