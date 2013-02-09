# Class: powerdns
#
# This module manages powerdns
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
class powerdns {
	$psql_host = "localhost"
	$psql_pdns_db = "powerdns"
	$psql_port = 5432
	$psql_password = "thegunsofbrixton"
	$psql_user = "powerdns"
	
	package { "pdns-server":
			ensure => installed,
	}
	package { "pdns-backend-pgsql":
			ensure => installed,
	}
	package { "pdns-recursor":
			ensure => installed,
	}

	file { "/etc/powerdns/pdns.conf":
		mode => 644,
		owner => root,
		group => root,
		require => Package['pdns-server'],
		ensure => present,
		content => template("tomoconnor-powerdns/pdns.erb"),
	}
	file { "/etc/powerdns/recursor.conf":
		mode => 644,
                owner => root,
                group => root,
                require => Package['pdns-server'],
                ensure => present,
		source => "puppet:///modules/tomoconnor-powerdns/recursor.conf",
	
	}
	file {"/etc/powerdns/schema.sql":
		mode => 644,
		owner => postgres,
		group => postgres,
		source => "puppet:///modules/tomoconnor-powerdns/schema.sql",
	}
	
	file {"/etc/powerdns/poweradmin.sql":
		mode => 644,
		owner => postgres,
		group => postgres,
		source => "puppet:///modules/tomoconnor-powerdns/poweradmin.sql",
	}

	service { "powerdns":
		name => "pdns",
		ensure => running,
		enable => true,
		hasrestart => true,
		hasstatus => true,
		pattern => "pdns_server",
	        require    => Package["pdns-server"],
		subscribe  => File["/etc/powerdns/pdns.conf"],
	}

	service { "powerdns-recursor":
		name => "pdns-recursor",
		ensure => stopped,
		hasrestart => true,
		hasstatus => true,
		pattern => "pdns_recursor",
		require => Package["pdns-recursor"],
		subscribe => File["/etc/powerdns/recursor.conf"],
	}
}
