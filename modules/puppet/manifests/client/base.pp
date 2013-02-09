class puppet::client::base {

  #TODO: deal with facts passed as env vars

  package { "facter":
    ensure  => present,
    require => Package["lsb-release"],
  }

  package { "puppet":
    ensure  => present,
    require => Package["facter"],
  }

  package { "lsb-release":
    ensure => present,
    name   => $operatingsystem ? {
      /Debian|Ubuntu|kFreeBSD/ => "lsb-release",
      /RedHat|CentOS|Fedora/   => "redhat-lsb",
    },
  }

  user { "puppet":
    ensure => present,
    require => Package["puppet"],
  }

  if (versioncmp($puppetversion, 2) > 0) {
    $agent = "agent"
  } else {
    $agent = "puppetd"
  }

  puppet::config {
    "main/ssldir":          value => "/var/lib/puppet/ssl";
    "$agent/server":        value => $puppet_server;
    "$agent/reportserver":  value => $puppet_reportserver;
    "$agent/report":        value => "true";
    "$agent/configtimeout": value => "3600";
    "$agent/pluginsync":    value => "true";
    "$agent/plugindest":    value => "/var/lib/puppet/lib";
    "$agent/libdir":        value => "/var/lib/puppet/lib";
    "$agent/pidfile":       value => "/var/run/puppet/puppetd.pid";
    "$agent/environment":   value => $puppet_environment;
    "$agent/diff_args":     value => "-u";
  }

}
