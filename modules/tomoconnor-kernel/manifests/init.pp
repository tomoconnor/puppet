# Class: kernel
#
# This module manages kernel
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
class kernel {
	file {"/etc/modprobe.conf":
		ensure => absent,
	}
	file {"/etc/modprobe.d":
		ensure => directory,
		owner => root,
		group => root,
	}
}
