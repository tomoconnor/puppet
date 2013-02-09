class kernel::nouveau::disable {
	file { "/etc/modprobe.d/":
		ensure => directory,
	}

	file { "/etc/modprobe.d/blacklist-nouveau.conf":
		ensure => file,
		owner  => root,
		group  => root,
		mode => 644,
		source => "puppet:///modules/tomoconnor-kernel/blacklist-nouveau.conf",
		notify => Exec["disable_nouveau"],
	
	}
	exec { "disable_nouveau":
		command => "/sbin/rmmod nouveau || true ",
		refreshonly => true,
	}
}

class kernel::nouveau{  
	case $operatingsystem {
	'Ubuntu','debian': {
        	include kernel::nouveau::disable
    	}
	default: {
		err("Not supported on anything that's not Ubuntu or Debian.")
	}
}
}
