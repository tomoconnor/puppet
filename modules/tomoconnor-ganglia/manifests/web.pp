class ganglia::web {
	package {"ganglia-web1":
		ensure => latest,
		alias => "ganglia_web",
	}

	file {"/var/www/html/ganglia":
		ensure => symlink,
		target => "/var/www/ganglia",
		owner => "www-data",
		group => "www-data",
	}
	file {["/var/www/ganglia/dwoo/compiled","/var/www/ganglia/dwoo/cache"]:
		owner => "www-data",
		group => "www-data",
		mode => 777,
	}
	Package['ganglia-web1'] -> File['/var/www/html/ganglia']
}	
