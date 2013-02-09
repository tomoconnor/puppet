class ganglia::client ($cluster='unspecified', $udp_port='8649', $udp_channel='239.2.11.71'){
	package {"ganglia-monitor":
		ensure => installed,
		alias => "ganglia_client",
	}

	service {"ganglia-monitor":
		require => Package['ganglia-monitor'],
		hasrestart => true,
		hasstatus => false,
		ensure => running,
		enable => true,
	}		
	
	file {"/etc/ganglia/gmond.conf":
		ensure => present,
		require => Package['ganglia-monitor'],
		content => template('tomoconnor-ganglia/gmond.conf.erb'),
		notify => Service['ganglia-monitor'],
	}
}
