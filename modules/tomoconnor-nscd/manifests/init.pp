# Class: nscd
#
# This module manages nscd
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
class nscd {
	package {"nscd":
		ensure => installed,
	}
	service {"nscd":
		ensure => running,
		enable => true,
		hasstatus => true,
		require => Package['nscd'],
	}

}

