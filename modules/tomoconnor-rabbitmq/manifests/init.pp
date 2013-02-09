# Class: rabbitmq
#
# This module manages rabbitmq
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
class rabbitmq {

	package {"rabbitmq-server":
		ensure => latest,
	}
	
	service {"rabbitmq-server":
		ensure => running,
		enable => true,
		hasrestart => true,
		hasstatus => true,
		require => Package['rabbitmq-server'],
	}

}
