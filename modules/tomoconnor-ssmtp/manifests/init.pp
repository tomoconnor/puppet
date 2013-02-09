# Class: ssmtp
#
# This module manages ssmtp
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
class ssmtp {

	package {"ssmtp":
		ensure => installed,
	}
	
	file {"/etc/ssmtp":
		ensure => directory,
		require => Package['ssmtp'],
	}
	file {"/etc/ssmtp/ssmtp.conf":
		content => template("tomoconnor-ssmtp/ssmtp.conf.erb"),
		owner =>root,
		group => root,
		mode => 644,
		require => Package['ssmtp'],
	}

	file {"/etc/ssmtp/revaliases":
		source => "puppet:///modules/tomoconnor-ssmtp/revaliases",
		owner => root,
		group => root,
		mode => 644,
	}	

}
