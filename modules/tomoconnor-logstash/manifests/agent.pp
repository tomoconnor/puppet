class logstash::agent {
	service {"logstash-agent":
		provider => upstart,
		ensure => running,
		require => Package['logstash'],
	}

	file {"/etc/logstash/indexer.conf":
		owner => root,
		group => root,
		mode => 644,
		source => "puppet:///tomoconnor-logstash/indexer.conf",
		notify => Service['logstash-agent'],
	}
}


