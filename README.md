# osm-ubuntu
Prerequisites

Vagrant (www.vagrantup.com)
Virtualbox (www.virtualbox.org)

Fire up a shell:

vagrant init puppetlabs/ubuntu-14.04-64-puppet;
modify the .vagrantfile: add:
config.vm.network "forwarded_port", host_ip: 127.0.0.1,  guest: 8888, host: 8888

vagrant up --provider virtualbox

for putty
puttygen
import %userprofile%\.vagrant.d\insecure_private_key
Export key to ppk format

putty

load/create connection (127.0.0.1:2222 default)
connection/data/auto-login username = vagrant
connection/ssh/auth: browse for newly minted ppk key for auth.	

/********************************************/

OSM manually
https://github.com/openstreetmap/openstreetmap-website/blob/master/INSTALL.md
sudo apt-get update

/*rvm*/

gpg --keyserver hkp://keys.gnupg.net --recv-keys 409B6B1796C275462A1703113804BB82D39DC0E3

\curl -sSL https://get.rvm.io | bash -s stable --ruby
\curl -sSL https://get.rvm.io | bash -s stable --rails

source /home/vagrant/.rvm/scripts/rvm



sudo apt-get install #ruby2.0 libruby2.0 ruby2.0-dev \
                     libmagickwand-dev libxml2-dev libxslt1-dev nodejs \
                     apache2 apache2-threaded-dev build-essential git-core \
                     postgresql postgresql-contrib libpq-dev postgresql-server-dev-all \
                     libsasl2-dev imagemagick
#sudo gem2.0 install bundler
gem install bundler

/* might want to clone somewhere else */
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

sudo apt-get install nginx

/etc/nginx/sites-available/nginx_vhost

server {
        listen 8888;
        server_name localhost;

        root /var/www/src/;
        index index.php index.html;

        sendfile off;

        location / {
                proxy_pass http://127.0.0.1:3000;
        }
}
     
    sudo ln -s /etc/nginx/sites-available/nginx_vhost /etc/nginx/sites-enabled/
    
    sudo rm -rf /etc/nginx/sites-available/default
    
    service nginx restart > /dev/null



