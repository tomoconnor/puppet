node basenode {
    class {'prerun': stage => 'pre'}

    $iface_netmask = "255.255.0.0"
    $iface_network = "192.168.0.0"
    $iface_broadcast = "192.168.255.255"
    $iface_gateway = "192.168.1.1"

    include rootsshkey
    include augeas
    include apt
    include bbdefault
    include ssh
    include sudo
    include ldap
    include ssmtp
    include network
    include facts
    include repositories
    include repositories::lucid
    include repositories::tomoconnor
    include repositories::ppa
    include repositories::optional
    include salt
    include applications::puppet
    include snmpd


    group { "admin":
        ensure => "present",
    }
    file {"/etc/cron.d/logcheck":
        owner => root,
        group => root,
        source => "puppet:///tomoconnor-applications/logcheck.cron",
    }

}

node verylittlenode {
	$iface_netmask = "255.255.0.0"
	$iface_network = "192.168.0.0"
	$iface_broadcast = "192.168.255.255"
	$iface_gateway = "192.168.1.1"
	package {"e1000e-dkms": ensure => latest, }
	include rootsshkey
	include nfs
	include nfs::mount
	include ntp::client
	include apt
	include bbdefault
	include ssh
	include sudo
	include ldap
	include ssmtp
	include network

	include snmpd
	include repositories
	include repositories::tomoconnor
	class {"ganglia::client":
	        cluster => "infrastructure",
	        udp_port => 8649,
	        udp_channel => "239.2.11.71",
	}


}

node storageservernode inherits verylittlenode {
	include facts
}

node hardwarebasenode inherits basenode{
    include nfs
    include nfs::mount
    include ntp::client
    package {"e1000e-dkms": ensure => latest, }
}




node workstation inherits hardwarebasenode {
    package {"apparmor": ensure => purged,}

    package {"dell2155cn1.0":
        ensure => latest,
        require => Package['apparmor'],
    }

    include gdm
    include removals
    include applications::developertools
    include applications::wacom
    include applications::skype
    include applications::misc
    include applications::devops
    include applications::google
    include applications::blender
    include applications::java
    include repositories::tomoconnor::unstable
    include repositories::tomoconnor
    include reepycheep::tools
    include kernel::nouveau
    include nvidia
    include applications::truecrypt
    include rsyslog
    include rsyslog::remote

    package {"gm-notify":
        ensure => latest,
        require => Apt::Ppa['ppa:gm-notify-maintainers/ppa'],
    }

    file {"/etc/apparmor.d/disable/usr.sbin.cupsd":
        ensure => symlink,
        target => "etc/apparmor.d/usr.sbin.cupsd",
    }

    exec { "gem install fpm":
        creates => "/usr/local/bin/fpm",
        timeout => 0,
        require => Package['rubygems'],
    }


   include applications::nothumbnails
    include applications::vnc
    class {"ganglia::client":
	cluster => "workstations",
        udp_port => 8649,
	udp_channel => '239.2.11.72',
    }

}


