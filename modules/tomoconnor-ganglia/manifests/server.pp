class ganglia::server {
	package {"rrdtool": ensure => latest,}
	package {"gmetad":
		ensure => present,
		require => Package['rrdtool'],
		alias => "ganglia_server",
	}
	service {"gmetad":
		require => Package['gmetad'],
		hasrestart => true,
                hasstatus => false,
                ensure => running,
                enable => true,
        }               
        
        file {"/etc/ganglia/gmetad.conf":
                ensure => present,
                require => Package['gmetad'],
		source => "puppet:///tomoconnor-ganglia/gmetad.conf",
                notify => Service['gmetad'],
        }
}


