#
# == Definition: puppet::environment
#
# Consistently configures environments in puppet.cfg.
#
# Parameters:
# - *ensure*: present/absent.
# - *path*: where the environment's manifests are located.
#
# Example usage:
#
#   puppet::environment {
#     "marc":  path => "/home/marc/puppet-manifests";
#     "test":  path => "/srv/puppet/test/manifests";
#     "stuff": path => "/tmp/stuff", ensure => absent;
#   }
#
#
define puppet::environment ($ensure='present', $path) {

  include puppet::environments

  $dirname = "${path}/puppetmaster"

  case $ensure {
    'present': {
      puppet::config {
        "${name}/modulepath":  value => "${dirname}/modules:${dirname}/site-modules";
        "${name}/manifestdir": value => "${dirname}/manifests";
        "${name}/manifest":    value => "${dirname}/manifests/site.pp";
      }
    }

    'absent': {
      augeas { "remove environment ${name}":
        changes => "rm /files/etc/puppet/puppet.conf/${name}",
        require => Package["puppet"],
      }
    }
  }
}
