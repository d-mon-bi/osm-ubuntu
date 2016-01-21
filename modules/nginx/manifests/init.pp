	class nginx {
  package { 'apache2.2-common':
    ensure => absent,
  }

  package { 'nginx':
    ensure => installed,
    require => Package['apache2.2-common'],
  }

  file { '/etc/nginx/sites-enabled/default':
    ensure => absent,
  }
  file { '/etc/nginx/sites-available/default':
    ensure => absent,
  }
  file { '/var/www':
    ensure => "directory",
    require => Package['nginx'],
  }
  class { 'osm::localhostproxy':
		require => Package['nginx'] }
	
  service { 'nginx':
    ensure => running,
    require => Package['nginx'],
    enable => true,
  }
}