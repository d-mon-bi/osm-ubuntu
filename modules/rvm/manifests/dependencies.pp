class rvm::dependencies {
  package { 'build-essential':
    ensure => installed,
  }
  package { 'bison':
    ensure => installed,
  }
  package {'openssl':
    ensure => installed,
  }
  package { 'libreadline6':
    ensure => installed,
  }
  package { 'libreadline6-dev':
    ensure => installed,
  }
  package { 'curl':
    ensure => installed,
  }
  package { 'git-core':
    ensure => installed,
  }
  package { 'zlib1g':
    ensure => installed,
  }
  package { 'zlib1g-dev':
    ensure => installed,
  }
  package { 'libssl-dev':
    ensure => installed,
  }
  package { 'libyaml-dev':
    ensure => installed,
  }
  package { 'libsqlite3-0':
    ensure => installed,
  }
  package { 'libsqlite3-dev':
    ensure => installed,
  }
  package { 'sqlite3':
    ensure => installed,
  }
  package { 'libxml2-dev':
    ensure => installed,
  }
  package { 'autoconf':
    ensure => installed,
  }
  package { 'libc6-dev':
    ensure => installed,
  }
}