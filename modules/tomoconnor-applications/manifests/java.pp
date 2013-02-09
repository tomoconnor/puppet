class applications::java {

	package {"oracle-java7-installer":
		ensure => latest,
		require => File['/usr/lib/mozilla/plugins'],
	}
	
	file {"/usr/lib/mozilla":
		ensure => directory,
                recurse => true,
                owner => root,
                group => root,
                mode => 755,
	}
	file {"/usr/lib/mozilla/plugins":
		ensure => directory,
		recurse => true,
		owner => root,
		group => root,
		mode => 755,
		require => File['/usr/lib/mozilla'],
	}
}
