class postgres::client {
	package{ ["postgresql-client-9.1", "postgresql-client-common"]:
		ensure => present,
	}
}
