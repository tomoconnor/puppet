class apache::security {

      package { "libapache-mod-security":
        ensure => present,
        alias => "apache-mod_security",
      }

  apache::module { ["unique_id", "security"]:
    ensure => present,
    require => Package["apache-mod_security"],
  }

}
