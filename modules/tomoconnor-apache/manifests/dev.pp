#
# == Class: apache::dev
#
# Installs package(s) required to build apache modules using apxs.
#
# Limitation: currently only works on redhat.
#
# Example usage:
#
#   include apache::dev
#
class apache::dev {

  package { "apache2-prefork-dev":
    ensure  => present,
    require => Package["gcc"],
  }
}
