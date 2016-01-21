class osm::install{
  $as_vagrant = 'sudo -u vagrant -H bash -l -c'

  file { '~/install.sh':
	source => "puppet:///modules/osm/files/install.sh",
	mode => 700,
  }
  
  exec { 'install-osm':
	path        => '/usr/bin:/usr/sbin:/bin',
    command	=> "${as_vagrant} '~/install.sh'",
  }
}