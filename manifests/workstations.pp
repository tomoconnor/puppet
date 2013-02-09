node devopsworkstation inherits workstation {
	include applications::spotify
	include repositories::tomoconnor::unstable
	package {"pidgin": ensure => latest}
	package {["kvmclient", "kvmclient-wrapper"]:
		ensure => latest,
	}
	include nfs::mount::tech


}

node /\w+\-(dev)$/ inherits workstation {
 ## We need to keep this to match any new arrivals.
}

node ssdworkstation inherits workstation {
	include ssd
	include ssd::partition
	include tmpreaper
	mount {"/var/tmp":
		device => "/dev/sdb1", # MASSSSSSIIIIIVE ASSUMPTION THAT IT'S SDB1
		ensure => mounted,
		fstype => "xfs",
		options => "noatime,auto",
		atboot => true,
		require => Class['ssd::partition'],
		}
	file {"/var/tmp":
		owner => root,
		group => root,
		mode => 1777,
		require => Mount['/var/tmp'],
	}	
}

