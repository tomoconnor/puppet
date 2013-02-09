# apt.pp

class apt {
	$root = '/etc/apt'
	$provider = 'apt-get'
	
	file { "sources.list.d":
		name => "${root}/sources.list.d",
		ensure => directory,
		owner => root,
		group => root,
	}
	
	exec { "apt_update":
		command => "${provider} update",
		subscribe => [ File["sources.list.d"] ],
		refreshonly => true,
	}
	package { "python-software-properties":
		ensure => installed,
	}
}
