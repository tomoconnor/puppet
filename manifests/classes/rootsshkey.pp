class rootsshkey {
	exec {"/usr/bin/ssh-keygen -b2048 -q -f /root/.ssh/id_rsa -N ''":
		creates => "/root/.ssh/id_rsa.pub",
		user => root,
		path => "/root",
		require => File["/root/.ssh"],
	}
	file {"/root/.ssh":
		ensure => directory,
		mode =>700,
		owner => root,
		group => root,
	}
}
