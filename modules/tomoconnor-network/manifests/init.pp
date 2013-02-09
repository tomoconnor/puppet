# Class: network
#
# This module manages network
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
class network {
	service { "networking": 
		ensure => running,
		hasrestart => true,
	}
	

}
