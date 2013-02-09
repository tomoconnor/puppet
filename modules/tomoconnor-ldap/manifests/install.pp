class ldap::install {
	include nscd
	
	package { "ldap-auth-config":
		ensure => installed,
		require => File['/etc/ldap.conf'],
	}
	package { "ldap-utils":
		ensure => installed,
	}
	package { "libldap-2.4-2":
		ensure => installed,
	}
	package { "libnss-ldap":
		ensure => installed,
	}
	package { "libpam-ldap":
		ensure => installed,
	}
	package { "python-ldap":
		ensure => installed,
	}

	package { "ldap-auth-client":
		ensure => installed,
		require => File['/etc/ldap.conf'],
	}
	exec { "auth-client-config":
	# Use the --check-system flag to check if ldap auth is setup or not, if not... well set it.
		unless  => "/usr/sbin/auth-client-config --check-system  --profile lac_ldap --type nss",
		command => "/usr/sbin/auth-client-config                 --profile lac_ldap --type nss",
		require => Package['ldap-auth-client'],
	}
	file { "/etc/auth-client-config/profile.d":
		ensure => directory,
		owner => root,
		group => root,
		mode => 755,
	}

	file { "/etc/auth-client-config/profile.d/ldap-auth-config":
		owner => root,
		group => root,
		mode => 644,
		source => "puppet:///modules/tomoconnor-ldap/ldap-auth-config",
	}

	file {"/etc/ldap.conf":
		owner => root,
		group => root,
		source => "puppet:///modules/tomoconnor-ldap/etc_ldap.conf",	
		require => Package['ldap-utils'],
	}
	file {"/etc/nsswitch.conf":
		owner => root,
		group => root,
		source => "puppet:///modules/tomoconnor-ldap/nsswitch.conf",
		notify => Service['nscd']
	}

	case $lsbdistcodename {
		'lucid':{
			exec { "pam-auth-update":
			user => root,
			path => "/usr/sbin",
			command	=> "/usr/sbin/pam-auth-update",
			}
		}
		'precise':{
			exec { "pam-auth-update":
                        user => root,
                        path => "/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin:/usr/games",
			provider => shell,
                        command => "/usr/sbin/pam-auth-update --package",
                        }
		}
	}	
		

}
