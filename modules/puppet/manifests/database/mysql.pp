class puppet::database::mysql {

  include mysql::server

  mysql::database { "puppet":
    ensure => present,
  }

  mysql::rights { "Set rights for puppet database":
    host     => '%', #TODO: allow only puppetmasters.
    database => $puppetdbname,
    user     => $puppetdbuser,
    password => $puppetdbpw,
  }

}
