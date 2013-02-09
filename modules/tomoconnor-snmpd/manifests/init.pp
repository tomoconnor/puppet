# Class: snmpd
#
# This module manages snmpd
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
class snmpd {

package {"snmpd":
	ensure => latest,
}

file {"/etc/snmp/snmpd.conf":
	owner => root,
	group => root,
	mode => 600,
	source => "puppet:///tomoconnor-snmpd/snmpd.conf",
	notify => Service['snmpd'],
}

file {"/etc/default/snmpd":
	owner => root,
        group => root,
        mode => 600,
        source => "puppet:///tomoconnor-snmpd/default.snmpd",
	notify => Service['snmpd'],
}


service{"snmpd":
	ensure     => running,
        hasstatus  => false,
        hasrestart => true,
        enable     => true,
    }	

Package['snmpd'] -> File['/etc/snmp/snmpd.conf'] -> File['/etc/default/snmpd'] -> Service['snmpd']
}
