# Class: tmpreaper
#
# This module manages tmpreaper
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
class tmpreaper {
	package {"tmpreaper":
		ensure => installed,
	}
	cron { "reapvartmp":
		command => "/usr/sbin/tmpreaper --mtime 30d --all /var/tmp",
		user => root,
		special => "reboot",
		require => Package['tmpreaper'],
	}
}
