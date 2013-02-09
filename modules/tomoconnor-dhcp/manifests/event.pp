class dhcp::event {
	file { "/usr/local/bin/dhcp-event":
		owner => root,
		group => root,
		source => "puppet:///modules/tomoconnor-dhcp/dhcp-event",
		mode => 755,
		require => [Package['python'], Package['python-psycopg2']], 
	}
	file { "/usr/local/bin/static-event":
		owner => root,
		group => root,
		source => "puppet:///modules/tomoconnor-dhcp/static-event",
		mode => 755,
		require => [Package['python'], Package['python-psycopg2']], 
	}
	file { "/etc/xinetd.d/staticevent":
		owner => root,
		group => root,
		source => "puppet:///modules/tomoconnor-dhcp/staticevent.conf",
		mode => 644,
		require => [File['/usr/local/bin/static-event'],Package['xinetd']],
		notify => Service['xinetd'],
	}
	package {"xinetd":
		ensure => installed,
	}
	service { "xinetd":
	        ensure  => running,
	        enable  => true,
	        require => [ Package["xinetd"], File["/etc/xinetd.conf"] ],
	        restart => "/etc/init.d/xinetd reload",
	} 
	file {"/etc/xinetd.conf":
		owner => root,
		group => root,
		source => "puppet:///modules/tomoconnor-dhcp/xinetd.conf",
		mode => 644,
	}
	file { "/etc/apparmor.d/usr.sbin.dhcpd":
		ensure => absent,
	}

	
	exec { "/etc/init.d/apparmor restart":
		user => root,
		group => root,
		subscribe => File['/etc/apparmor.d/usr.sbin.dhcpd'],
		refreshonly => true,
	}

	package { "python":
		ensure => installed,
	}

	package {"python-ipy":
		ensure => latest,
	}
}
