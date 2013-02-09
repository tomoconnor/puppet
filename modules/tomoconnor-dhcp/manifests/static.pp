class dhcp::static {
	$nomacaddress = "00:00:00:00:00:00"
	if $macaddress{
		exec { "/bin/echo ${hostname} ${ipaddress} ${macaddress} ${domain} | `which netcat` dns-1.london.tomoconnor.eu 9999":
			timeout => 60,
			require => Package['netcat'],
		}
	}else{
		exec { "/bin/echo ${hostname} ${ipaddress} ${nomacaddress} ${domain} | `which netcat` dns-1.london.tomoconnor.eu 9999":
			timeout => 60,
			require => Package['netcat'],
		}
	}

	file {"/etc/resolv.conf":
		owner => root,
		group => root,
		mode => 644,
		source => "puppet:///modules/tomoconnor-dhcp/resolv.conf",
	}
}
