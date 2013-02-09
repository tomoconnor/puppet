class postgres::backup {
	file {"/usr/local/bin/weekly-pgbackup":
		owner => root,
		group => root,
		mode => 755,
		source => "puppet:///modules/tomoconnor-postgres/weekly-pgbackup.sh",
		require => File['/var/lib/backups/postgresql'],
	}
	file {"/usr/local/bin/daily-pgbackup":
		owner => root,
		group => root,
		mode => 755,
		source => "puppet:///modules/tomoconnor-postgres/daily-pgbackup.sh",
		require => File['/var/lib/backups/postgresql'],
	}

	file {"/var/lib/backups":
		ensure => directory,
		owner => root,
		group => root,
		mode => 666,
	}
	file {"/var/lib/backups/postgresql":
		ensure => directory,
		owner => root,
		group => root,
		mode => 666,
		require => File['/var/lib/backups'],
	}
	
	file {"/etc/cron.daily/daily-pgbackup":
		ensure => symlink,
		target => "/usr/local/bin/daily-pgbackup",
		require => File['/usr/local/bin/daily-pgbackup'],
	}

	file {"/etc/cron.weekly/weekly-pgbackup":
		ensure => symlink,
		target => "/usr/local/bin/weekly-pgbackup",
		require => File['/usr/local/bin/weekly-pgbackup'],
	}
}
