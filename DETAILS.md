
## What this manifest does:
This puppet manifest will proceed to:
### Install RVM and use it to install Ruby on Rails
```
gpg --keyserver hkp://keys.gnupg.net --recv-keys 409B6B1796C275462A1703113804BB82D39DC0E3

\curl -sSL https://get.rvm.io | bash -s stable --ruby
\curl -sSL https://get.rvm.io | bash -s stable --rails

source /home/vagrant/.rvm/scripts/rvm
```

### Download and install prerequisites for OpenStreetMap

https://github.com/openstreetmap/openstreetmap-website/blob/master/INSTALL.md
```
sudo apt-get update
sudo apt-get install \
                     libmagickwand-dev libxml2-dev libxslt1-dev nodejs \
                     apache2 apache2-threaded-dev build-essential git-core \
                     postgresql postgresql-contrib libpq-dev postgresql-server-dev-all \
                     libsasl2-dev imagemagick
gem install bundler
```

### Download and install prerequisites for OpenStreetMap
```
git clone --depth=1 https://github.com/openstreetmap/openstreetmap-website.git
cd openstreetmap-website
bundle install
cp config/example.application.yml config/application.yml
cp config/example.database.yml config/database.yml
sudo -u postgres -i
createuser -s <username>
exit
bundle exec rake db:create
/* for tests to run, do this on osm_test as well */
psql -d openstreetmap -c "CREATE EXTENSION btree_gist"
cd db/functions
make libpgosm.so
cd ../..
psql -d openstreetmap -c "CREATE FUNCTION maptile_for_point(int8, int8, int4) RETURNS int4 AS '`pwd`/db/functions/libpgosm', 'maptile_for_point' LANGUAGE C STRICT"
psql -d openstreetmap -c "CREATE FUNCTION tile_for_point(int4, int4) RETURNS int8 AS '`pwd`/db/functions/libpgosm', 'tile_for_point' LANGUAGE C STRICT"
psql -d openstreetmap -c "CREATE FUNCTION xid_to_int4(xid) RETURNS int4 AS '`pwd`/db/functions/libpgosm', 'xid_to_int4' LANGUAGE C STRICT"
bundle exec rake db:migrate
bundle exec rails server
```

### Download and install NGINX
```
sudo apt-get install nginx
```

### Configure NGINX to work as a proxy from the host to the ruby on rails server running OSM

Modify the /etc/nginx/sites-available/nginx_vhost file
```
server {
        listen 8888;
        server_name localhost;


        sendfile off;

        location / {
                proxy_pass http://127.0.0.1:3000;
        }
}
```
Execute:
```     
    sudo ln -s /etc/nginx/sites-available/nginx_vhost /etc/nginx/sites-enabled/
    
    sudo rm -rf /etc/nginx/sites-available/default
    
    service nginx restart > /dev/null
```



