class apache::administration {

  include apache::params

  $distro_specific_apache_sudo = "/usr/sbin/apache2ctl"

  group { "apache-admin":
    ensure => present,
  }

  # used in erb template
  $wwwpkgname = $apache::params::pkg
  $wwwuser    = $apache::params::user

  sudo::directive { "apache-administration":
    ensure => present,
    content => template("tomoconnor-apache/sudoers.apache.erb"),
    require => Group["apache-admin"],
  }

}
