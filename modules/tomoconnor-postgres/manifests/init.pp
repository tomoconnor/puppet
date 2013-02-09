# Class: postgres
#
# This module manages postgres
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
class postgres {
	
	package { "postgresql": ensure => latest}
	package { ["postgresql-8.4","postgresql-client-8.4",]:
			ensure => purged,
	}
	
	service { postgresql:
		ensure => running,
		enable => true,
		hasstatus => true,
		subscribe => Package['postgresql']
	}
	include postgres::config
	postgres::role{ "root":
                ensure => present,
                password => "",
        }
        postgres::database { "root":
                ensure => present,
        }
        postgres::grant { "grant root on root":
                ensure => present,
                owner => root,
                database => root,
        }
	package {"python-psycopg2":
		ensure => latest,
	}
	file {"/var/lib/postgresql/9.1/main/server.crt":
		ensure => symlink,
		target => "/etc/ssl/certs/ssl-cert-snakeoil.pem",
	}

	file {"/var/lib/postgresql/9.1/main/server.key":
		ensure => symlink,
		target => "/etc/ssl/private/ssl-cert-snakeoil.key",
	}
}
