class postgres::libraries{
	package { 'python-psycopg2':
		ensure => installed,
	}
}

