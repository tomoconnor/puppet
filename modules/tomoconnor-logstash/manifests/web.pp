class logstash::web {
	service {"logstash-web":
		provider => upstart,
		require => Package['logstash'],
		ensure => running,
	}
}
