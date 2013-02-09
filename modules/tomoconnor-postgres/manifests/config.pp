class postgres::config {

	file {"/etc/postgresql/9.1/main/environment":
		owner => postgres,
		group => postgres,
		mode => 644,
		source => "puppet:///modules/tomoconnor-postgres/environment",
		require => Package['postgresql'],
	}
	file {"/etc/postgresql/9.1/main/pg_ctl.conf":
		owner => postgres,
		group => postgres,
		mode => 644,
		source => "puppet:///modules/tomoconnor-postgres/pg_ctl.conf",
		require => Package['postgresql'],
	}
	file {"/etc/postgresql/9.1/main/pg_hba.conf":
		owner => postgres,
		group => postgres,
		mode => 644,
		source => "puppet:///modules/tomoconnor-postgres/pg_hba.conf",
		require => Package['postgresql'],
		notify => Service['postgresql'],
	}
	file {"/etc/postgresql/9.1/main/pg_ident.conf":
		owner => postgres,
		group => postgres,
		mode => 644,
		source => "puppet:///modules/tomoconnor-postgres/pg_ident.conf",
		require => Package['postgresql'],
	}
	file {"/etc/postgresql/9.1/main/postgresql.conf":
		owner => postgres,
		group => postgres,
		mode => 644,
		source => "puppet:///modules/tomoconnor-postgres/postgresql.conf",
		require => Package['postgresql'],
		notify => Service['postgresql'],
	}
	file {"/etc/postgresql/9.1/main/start.conf":
		owner => postgres,
		group => postgres,
		mode => 644,
		source => "puppet:///modules/tomoconnor-postgres/start.conf",
		require => Package['postgresql'],
	}
}
