node genericserver inherits basenode {
	class {"ganglia::client":
		cluster => "infrastructure",
		udp_port => 8653,
		udp_channel => "239.2.11.74",
	}
}


node puppetmaster inherits basenode {
	$puppet_server = "puppet"

	include puppet::client::base
	include puppet::master::webrick

	puppet::config { "service config":
			notify => Service["puppetmaster"] 
	}

	puppet::config {
		"main/logdir":  value => "/var/log/puppet";
		"main/vardir":  value => "/var/lib/puppet";
		"main/rundir":  value => "/var/run/puppet";
		"main/confdir": value => "/etc/puppet";
		"ca/ssldir":          value => "/var/lib/puppet/ssl";
		"master/ssldir":      value => "/var/lib/puppet/ssl";
		"master/certname":    value => "puppet";
	}  
	file {"/etc/puppet/ssl":
		ensure => directory,
		mode => 0600,
		recurse => true,
		owner => "root",
		group => "root",
	}
	class {"ganglia::client":
		cluster => "infrastructure",
	        udp_port => 8653,
	}

}
	
node dns_server inherits basenode{
	include postgres

	postgres::role{ "defadmin":
		ensure => present,
		password => "",
	}
	postgres::database {"defadmin":
		ensure => present,
	}
	postgres::grant {"grant defadmin on defadmin":
		ensure => present,
		owner => defadmin,
		database => defadmin,
	}

	postgres::role{ "replicant":
		ensure => present,
		password => "",
	}
	postgres::database {"replicant":
		ensure => present,
	}
	postgres::grant {"grant replicant on replicant":
		ensure => present,
		owner => replicant,
		database => replicant,
	}


	postgres::role{ "powerdns":
		ensure => present,
		password => "",
	}
	postgres::database { "powerdns":
		ensure => present,
	}
	postgres::grant { "grant powerdns on powerdns":
		ensure => present,
		owner => powerdns,
		database => powerdns,
	}
	include powerdns
	class {"ganglia::client":
		cluster => "infrastructure",
	        udp_port => 8653,
		udp_channel => "239.2.11.74",
	}
}	
node dhcp_dns_server inherits dns_server {
	include dhcp::server
	include dhcp::event
}

node "dns-2" inherits dns_server {
	#slave (hot standby)
	$psql_master = 'dns-1'
	include postgres::replicate::slave
	include postgres::backup
	include dhcp::static 
}

node "dns-1" inherits dhcp_dns_server {
	#master
	include powerdns::poweradmin
	include dhcp::static
	
}

node "ntp-1", "ntp-2" inherits genericserver {
	include ntp::server
}

node "logger-1" inherits genericserver {
#	$iface_ipaddress = ''
#	$iface_netmask = ''
#	$iface_network = ''
#	$iface_broadcast = ''
#	$iface_gateway = ''
	include dhcp::static
	include network::bonded
	include logstash
	include elasticsearch
	include rabbitmq
	include logstash::agent
	include logstash::web
	include logstash::shipper
	include augeas
	include apache::debian
	include php
	include php::apache
	php::module {"curl":
		notify => Service['apache'],
    	}
	package {"kibana1.0":
		ensure => latest,
	}
	class { mongodb:
		ulimit_nofile => 20000,
	}
	package {"graylog2":
		ensure => latest,
	}
	include opennms
	include ganglia::server
	include ganglia::web
	include ganglia::server::datasources::all
}

