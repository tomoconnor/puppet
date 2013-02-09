class applications::developertools{
	$package_list = [ "git-core",
                      "git-gui",
                      "gitk",
                      "scite",
                      "qt4-designer",
                      "qt4-dev-tools",
                      "qtcreator",
                      "cmake",
                      "gitweb",
                    ]

	package { $package_list: ensure => "installed" }
	package { "fpm":
		ensure => latest,
	}
	file {"/usr/local/bin/fpm":
		ensure => symlink,
		target => "/var/lib/gems/1.8/bin/fpm",
		require => Package['fpm'],
	}
	file {"/usr/local/bin/fpm-npm":
		ensure => symlink,
		target => "/var/lib/gems/1.8/bin/fpm-npm",
		require => Package['fpm'],
	}
}

