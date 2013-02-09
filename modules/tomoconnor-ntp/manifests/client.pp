class ntp::client {
	package {"ntp":
		ensure => installed,
	}
	package {"ntpdate":
		ensure => installed,
	}

	file {"/etc/ntp.conf":
		mode => 644,
		source => "puppet:///modules/tomoconnor-ntp/ntp.conf",
		notify => Service['ntpd'],
		require => Package['ntp'],
	}

	service { "ntpd":
		name => "ntp",
		ensure => running,
		enable => true,
		require => Package['ntp'],
	}

}
