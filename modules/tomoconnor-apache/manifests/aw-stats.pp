define apache::aw-stats($ensure=present, $aliases=[]) {

  include apache::params

  # used in ERB template
  $wwwroot = $apache::params::root

  file { "/etc/awstats/awstats.${name}.conf":
    ensure  => $ensure,
    content => template("apache/awstats.erb"),
    require => [Package["apache"], Class["apache::awstats"]],
  }

  file { "${apache::params::root}/${name}/conf/awstats.conf":
    ensure  => $ensure,
    owner   => root,
    group   => root,
    source  => "puppet:///modules/tomoconnor-apache/awstats.deb.conf",
    seltype => $operatingsystem ? {
      "RedHat" => "httpd_config_t",
      "CentOS" => "httpd_config_t",
      default  => undef,
    },
    notify  => Exec["apache-graceful"],
    require => Apache::Vhost[$name],
  }
}
