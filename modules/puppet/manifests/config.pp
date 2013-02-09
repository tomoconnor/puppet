#
# == Definition: puppet::config
#
# Simple wrapper around augeas to set values to options in
# /etc/puppet/puppet.conf
#
# Example:
#   puppet::config { "main/ssldir": value => "/var/lib/ssl" }
#   puppet::config { "ca/ssldir":   value => "/srv/puppetca" }
#
define puppet::config ($value='default value') {

  augeas { "set puppet config parameter '${section}/${name}' to '${value}'":
    changes => $value ? {
      'default value' => "rm  /files/etc/puppet/puppet.conf/${name}",
      default         => "set /files/etc/puppet/puppet.conf/${name} ${value}",
    },
    require => Package["puppet"],
  }

}
