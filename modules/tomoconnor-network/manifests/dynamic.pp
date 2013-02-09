class network::dynamic {
	file {"/etc/network/interfaces":
		owner => root,
		group => root,
		mode => 644,
		source => "puppet:///modules/tomoconnor-network/interfaces",
		notify => Service["networking"],
	}
}
	
