class dhcp::server{
	package { "dhcp3-server":
		ensure => installed,
	}

	file { "/etc/dhcp/dhcpd.conf":
		path => $lsbdistcodename ? {
			'lucid' => "/etc/dhcp3/dhcpd.conf",
			'oneiric' => "/etc/dhcp/dhcpd.conf",
		},
		owner => root,
		group => root,
		mode => 644,
		source => "puppet:///modules/tomoconnor-dhcp/dhcpd.conf",
		require => Package["dhcp3-server"],
		
	}

	
	service { "dhcpd":
		name => $lsbdistcodename ? {
			'oneiric' => "isc-dhcp-server",
			'lucid' => "dhcp3-server",
			default => "dhcpd",
			},
		pattern => $lsbdistcodename ? {
			'oneiric' => 'dhcpd',
			'lucid' => 'dhcpd3',
			},
		ensure => running,
		enable => true,
		hasstatus => true,
		require => [ Package["dhcp3-server"], File['/etc/dhcp/dhcpd.conf'] ],
		subscribe => File['/etc/dhcp/dhcpd.conf'],
	}

	
}
