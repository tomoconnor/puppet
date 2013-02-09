class network::static {
	file { "/etc/network/interfaces":
		owner => root,
		group => root,
		mode => 644,
		content => template("tomoconnor-network/interfaces.erb"),
		notify => Service["networking"],
	}

}
