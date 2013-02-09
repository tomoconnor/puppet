# Class: rsyslog
#
# This module manages rsyslog
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
class rsyslog {
	package{"rsyslog":
		ensure => latest,
	}
	
	file {"/etc/rsyslog.conf":
		owner => root,
                group => root,
                mode => 644,
                source => "puppet:///modules/tomoconnor-rsyslog/rsyslog.conf",
		notify => Service['rsyslog'],
        }

	file {"/var/log/rsyslog":
		ensure => directory,
		owner => root,
		group => root,
		mode => 644,
	}
	file {"/etc/rsyslog.d/20-ufw.conf":
		owner => root,
                group => root,
                mode => 644,
                source => "puppet:///modules/tomoconnor-rsyslog/20-ufw.conf",
		notify => Service['rsyslog'],
        }
	file {"/etc/rsyslog.d/50-default.conf":
		owner => root,
                group => root,
                mode => 644,
                source => "puppet:///modules/tomoconnor-rsyslog/50-default.conf",
		notify => Service['rsyslog'],
        }

	service {"rsyslog":
		ensure => running,
		enable => true,
	}
	
	Package['rsyslog'] -> File['/etc/rsyslog.d/20-ufw.conf'] -> File['/etc/rsyslog.d/50-default.conf'] -> File['/var/log/rsyslog'] -> Service['rsyslog']
}


