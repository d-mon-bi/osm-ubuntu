class osm::dependencies {
  package { 'ruby2.0':
    ensure => installed,
  }
  package { 'libruby2.0':
    ensure => installed,
  }
  package {'ruby2.0-dev':
    ensure => installed,
  }
  package { 'libmagickwand-dev':
    ensure => installed,
  }
  package { 'libxml2-dev':
    ensure => installed,
  }
  package { 'libxslt1-dev':
    ensure => installed,
  }
  package { 'nodejs':
    ensure => installed,
  }
  package { 'apache2':
    ensure => installed,
  }
  package { 'apache2-threaded-dev':
    ensure => installed,
  }
  package { 'build-essential':
    ensure => installed,
  }
  package { 'git-core':
    ensure => installed,
  }
  package { 'postgresql':
    ensure => installed,
  }
  package { 'postgresql-contrib':
    ensure => installed,
  }
  package { 'libpq-dev':
    ensure => installed,
  }
  package { 'postgresql-server-dev-all':
    ensure => installed,
  }
  package { 'libsasl2-dev':
    ensure => installed,
  }
  package { 'imagemagick':
    ensure => installed,
  }
}