class applications::wacom {
	package {"wacom-dkms":
		ensure => latest,
	}
	package {"wacom-utility":
		ensure => latest,
	}

	file {"/usr/lib/X11/xorg.conf.d/10-wacom.conf":
		mode => 644,
		owner => root,
		group => root,
		source => "puppet:///modules/tomoconnor-applications/wacom.conf",
		require => Package["wacom-dkms"],
	}
}
