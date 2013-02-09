class puppet::client::daemon {

  include puppet::client::base

  service { "puppet":
    ensure    => running,
    enable    => true,
    hasstatus => true,
  }

  file { "/usr/local/bin/launch-puppet":
    ensure => absent,
  }

  cron { "puppetd":
    ensure => absent,
    user   => "root",
  }
}
