# Class: elasticsearch
#
# This module manages elasticsearch
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
class elasticsearch {
	package {"elasticsearch":
		ensure => latest,
		
	}
	service {"elasticsearch":
		ensure => running,
		enable => true,
		hasrestart => true,
		hasstatus => true,
		require => Package['elasticsearch'],
	}

	Package['elasticsearch'] -> Service['elasticsearch'] 
}
