class powerdns::poweradmin{
	package { "poweradmin":
		ensure => installed,
	}

	include apache

	package {"php-mdb2-driver-pgsql":
		ensure => latest,
	}

	package {"php5-pgsql":
		ensure => latest,
	}
	
}

