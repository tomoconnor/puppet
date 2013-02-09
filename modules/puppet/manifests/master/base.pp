class puppet::master::base {

  package { "puppetmaster":
    ensure => present,
    name   => $operatingsystem ? {
      /Debian|Ubuntu/        => "puppetmaster",
      /RedHat|CentOS|Fedora/ => "puppet-server",
    },
  }

  # used by puppetdoc -m pdf
  package { "python-docutils": ensure => present }

  if $operatingsystem =~ /RedHat|CentOS|Fedora/ {
    package { "ruby-rdoc": ensure => present }
  }

  if (versioncmp($puppetversion, 2) > 0) {
    $master = "master"
  } else {
    $master = "puppetmasterd"
  }

  case $puppetdbtype {
    "mysql": {

      package { "ruby-mysql":
        ensure => present,
        name   => $operatingsystem ? {
          /Debian|Ubuntu/        => "libdbd-mysql-ruby",
          /RedHat|CentOS|Fedora/ => "ruby-mysql",
        },
      }

      puppet::config {
        "${master}/dbadapter":    value => "mysql";
        "${master}/storeconfigs": value => "true";
        "${master}/dbmigrate":    value => "true";
        "${master}/dbserver":     value => $puppetdbhost;
        "${master}/dbname":       value => $puppetdbname;
        "${master}/dbuser":       value => $puppetdbuser;
        "${master}/dbpassword":   value => $puppetdbpw;
      }
    }

    "sqlite": {
      package { ["sqlite3", "libsqlite3-ruby"]:
        ensure => present,
      }

      puppet::config {
        "${master}/dbadapter":    value => "sqlite3";
        "${master}/storeconfigs": value => "true";
        "${master}/dbmigrate":    value => "true";
        "${master}/dbserver":     value => $puppetdbhost;
        "${master}/dbname":       value => $puppetdbname;
        "${master}/dbuser":       value => $puppetdbuser;
        "${master}/dbpassword":   value => $puppetdbpw;
      }
    }

    default: {
      puppet::config {
        "${master}/dbadapter":    ;
        "${master}/storeconfigs": value => "false";
        "${master}/dbmigrate":    ;
        "${master}/dbserver":     ;
        "${master}/dbname":       ;
        "${master}/dbuser":       ;
        "${master}/dbpassword":   ;
      }
    }

  }

}
