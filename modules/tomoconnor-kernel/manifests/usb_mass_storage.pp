class kernel::usb_mass_storage::disable {
	file { "/etc/modprobe.d/":
		ensure => directory,
	}

	file { "/etc/modprobe.d/blacklist-usb.conf":
		ensure => file,
		owner  => root,
		group  => root,
		mode => 644,
		source => "puppet:///modules/tomoconnor-kernel/blacklist-usb-mass-storage.conf",
		notify => Exec["disable_usb_storage"],
	
	}
	exec { "disable_usb_storage":
		command => "/sbin/rmmod usb_storage || true ",
		refreshonly => true,
	}
}

class kernel::usb_mass_storage {  
	case $operatingsystem {
	'Ubuntu','debian': {
        	include kernel::usb_mass_storage::disable
    	}
	default: {
		err("Not supported on anything that's not Ubuntu or Debian.")
	}
}
}
