class osm::install{
  $as_vagrant = 'sudo -u vagrant -H bash -l -c'
  $install_sh = '#!/bin/bash
sudo gem2.0 install bundler
git clone --depth=1 https://github.com/openstreetmap/openstreetmap-website.git
cd openstreetmap-website
bundle install
cp config/example.application.yml config/application.yml
cp config/example.database.yml config/database.yml
sudo -u postgres -H bash -l -c \'createuser -s vagrant\'
bundle exec rake db:create
psql -d openstreetmap -c "CREATE EXTENSION btree_gist"
cd db/functions
make libpgosm.so
cd ../..
psql -d openstreetmap -c "CREATE FUNCTION maptile_for_point(int8, int8, int4) RETURNS int4 AS \'`pwd`/db/functions/libpgosm\', \'maptile_for_point\' LANGUAGE C STRICT"
psql -d openstreetmap -c "CREATE FUNCTION tile_for_point(int4, int4) RETURNS int8 AS \'`pwd`/db/functions/libpgosm\', \'tile_for_point\' LANGUAGE C STRICT"
psql -d openstreetmap -c "CREATE FUNCTION xid_to_int4(xid) RETURNS int4 AS \'`pwd`/db/functions/libpgosm\', \'xid_to_int4\' LANGUAGE C STRICT"
bundle exec rake db:migrate'

  file { '/home/vagrant/install.sh':
	content => "$install_sh",
	mode => '777',
  }
  
  exec { 'install-osm':
	path        => '/usr/bin:/usr/sbin:/bin',
    command		=> "${as_vagrant} '/home/vagrant/install.sh'",
	require 	=> File['/home/vagrant/install.sh'],
	timeout 	=>  3600,
  }
}