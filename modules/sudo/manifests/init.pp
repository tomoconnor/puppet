class sudo {
  package {"sudo":
    ensure => "present",
  }

  file {"/etc/sudoers":
    ensure => present,
    owner  => root,
    group  => root,
    mode   => 440,
    source => "puppet:///modules/sudo/sudoers"
  }

}

