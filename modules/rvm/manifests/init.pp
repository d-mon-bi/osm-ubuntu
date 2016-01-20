class rvm {
  $as_vagrant = 'sudo -u vagrant -H bash -l -c'

  class { 'rvm::dependencies':
    before => Exec['update-keys-rvm']
  }
  exec { 'update-keys-rvm':
    path        => '/usr/bin:/usr/sbin:/bin',
    command	=> "${as_vagrant} 'gpg --keyserver hkp://keys.gnupg.net --recv-keys 409B6B1796C275462A1703113804BB82D39DC0E3'",
  }
  exec { 'system-rvm':
    path        => '/usr/bin:/usr/sbin:/bin',
    command     => "${as_vagrant} '/usr/bin/curl -sSL https://get.rvm.io | bash -s stable --rails'",
    creates     => '/usr/local/rvm/bin/rvm',
    timeout	=> 3600,
    require     => Exec['update-keys-rvm'],
  }
  exec { 'install_ruby':
  # We run the rvm executable directly because the shell function assumes an
  # interactive environment, in particular to display messages or ask questions.
  # The rvm executable is more suitable for automated installs.
  #
  # Thanks to @mpapis for this tip.
  command => "${as_vagrant} '${home}/.rvm/bin/rvm install 2.0.0 --latest-binary --autolibs=enabled && rvm --fuzzy alias create default 2.0.0'",
  creates => "${home}/.rvm/bin/ruby",
  path        => '/usr/bin:/usr/sbin:/bin',
  require => Exec['system-rvm']
}
exec { "${as_vagrant} 'gem install bundler --no-rdoc --no-ri'":
  creates => "${home}/.rvm/bin/bundle",
  path        => '/usr/bin:/usr/sbin:/bin',
  require => Exec['install_ruby']
}
}