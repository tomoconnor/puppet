class network::bonded {
	package {"ifenslave-2.6":
		ensure => installed,
	}

	file { "/etc/network/interfaces":
		owner => root,
		group => root,
		mode => 644,
		content => template("tomoconnor-network/bonding.erb"),
		notify => Service["networking"],
		require => Package['ifenslave-2.6'],
	}
	
	exec {"/sbin/modprobe bonding mode=1 miimon=100":
		require => Package['ifenslave-2.6'],
	}
	
	exec {"/bin/echo bonding mode=1 miimon=100 >> /etc/modules":
		require => Package['ifenslave-2.6'],
		unless => "grep -qFx 'bonding mode=1 miimon=100' /etc/modules",
	}
	
		
	
}

