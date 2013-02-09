class applications::wine {
	apt::ppa { "ppa:ubuntu-wine/ppa": }


	exec {"wine_update":
		command => "apt-get update",
		user => root,
	}
	
	package {"wine1.3":
		ensure => latest,
	}

	Apt::Ppa['ppa:ubuntu-wine/ppa'] -> Exec['wine_update'] -> Package['wine1.3']
}
