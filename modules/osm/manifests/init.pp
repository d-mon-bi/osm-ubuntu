class osm {
  exec { 
    'apt-get update': 
        path        => '/usr/bin:/usr/sbin:/bin',         
        command	=> "apt-get update", 
  }
  class { 'osm::dependencies':
    require => Exec['apt-get update']
  }

	include nginx
	#RVM having issues with some gems, tring without include rvm
	class { 'osm::install':
		require => Class['osm::dependencies']}
}