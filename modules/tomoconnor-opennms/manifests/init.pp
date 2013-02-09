# Class: opennms
#
# This module manages opennms
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
class opennms {

file {"/etc/apt/sources.list.d/opennms.list":
	owner => root,
	group => root,
	mode => 644,
	source => "puppet:///tomoconnor-opennms/opennms.list",
}
exec {"opennms-key":
	command => "wget -O - http://debian.opennms.org/OPENNMS-GPG-KEY | apt-key add -",
	provider => shell,
}

exec {"opennms-agu":
	command => "apt-get update",
}

file {"/etc/postgresql/9.1/main/pg_hba.conf":
	owner => postgres,
	group => postgres,
	mode => 640,
	source => "puppet:///tomoconnor-opennms/pg_hba.conf",
}
exec {"opennms-reload-psql":
	command => "/etc/init.d/postgresql restart",
}
exec {"opennms-createpsqluser":
	cwd => "/tmp",
	command => "sudo -u postgres createuser -d -l -s opennms -U postgres",
}
package {"opennms":
	ensure => present,
}
exec {"opennms-setjava":
	command => "/usr/share/opennms/bin/runjava -S /usr/lib/jvm/java-7-oracle/bin/java",
}

exec {"opennms-precreatedb":
	provider => shell,
	command => 'createdb -E UNICODE --lc-ctype="en_GB.utf8" --lc-collate="en_GB.utf8" -O opennms -U opennms -T template0 opennms && touch /usr/share/opennms/logs/.puppet_createdb',
	unless => "test -e /usr/share/opennms/logs/.puppet_createdb",
}

exec {"opennms-initdb":
	provider => shell,
	command => "/usr/share/opennms/bin/install -dis && touch /usr/share/opennms/logs/.puppet_initdb",
	unless => "test -e /usr/share/opennms/logs/.puppet_initdb",
}

service {"opennms":
	ensure => running,
	enable => true,
	hasrestart => true,
	hasstatus => false,
	
}

exec {"opennms-start":
	command => "/etc/init.d/opennms start",
	provider => shell,
}

File['/etc/apt/sources.list.d/opennms.list'] -> Exec['opennms-key'] -> Exec['opennms-agu'] File['/etc/postgresql/9.1/main/pg_hba.conf'] -> Exec['opennms-reload-psql'] -> Exec['opennms-createpsqluser'] -> Package['opennms'] -> Exec['opennms-setjava'] -> Exec['opennms-precreatedb'] -> Exec['opennms-initdb'] -> Service['opennms'] -> Exec['opennms-start']

}
