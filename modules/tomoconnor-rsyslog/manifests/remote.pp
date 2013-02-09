class rsyslog::remote {
	file {"/etc/rsyslog.d/10-remote.conf":
		owner => root,
		group => root,
		mode => 644,
		source => "puppet:///modules/tomoconnor-rsyslog/10-remote.conf",
		notify => Service['rsyslog'],
	}
	file {"/var/log/rsyslog/work":
		ensure => directory,
		owner => root,
		group => root,
		mode => 640,
		recurse => true,
	}
				
	Package['rsyslog'] -> File['/var/log/rsyslog/work'] -> File['/etc/rsyslog.d/10-remote.conf'] 

}
