class logstash::shipper {
	service {"logstash-shipper":
		provider => upstart,
		require => Package['logstash'],
		ensure => running,
	}
	file {"/etc/logstash/shipper.conf":
		owner => root,
		group => root,
		mode => 644,
		source => "puppet:///tomoconnor-logstash/shipper.conf",
		notify => Service['logstash-agent'],
	}


}

