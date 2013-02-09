class postgres::replicate::slave{
	file {"/var/lib/postgresql/9.1/main/recovery.conf":
		owner => postgres,
		group => postgres,
		mode => 644,
		content => template("tomoconnor-postgres/recovery.conf.erb"),
	}

	file {"/usr/local/bin/check_lag.sh":
		owner => root,
		group => root,
		mode => 755,
		source => "puppet:///modules/tomoconnor-postgres/check_lag.sh",
	}
	file {"/etc/cron.d/check_lag":
		owner => root,
		group => root,
		mode => 644,
		source => "puppet:///modules/tomoconnor-postgres/check_lag.cron",
		require => File['/usr/local/bin/check_lag.sh'],
	}
}

