# Class: logstash
#
# This module manages logstash
#
# Parameters:
#
# Actions:
#
# Requires:
#
# Sample Usage:
#
# [Remember: No empty lines between comments and class definition]
import "*.pp"
class logstash {

	package {"logstash":
		ensure => latest,
	}

  file { "/var/www/html/index.html":
    ensure  => present,
    owner   => root,
    group   => root,
    mode    => 644,
    source => "puppet:///tomoconnor-logstash/index.html",
  }

}
