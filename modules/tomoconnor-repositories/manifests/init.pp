# Class: repositories
#
# This module manages repositories
#
# Parameters:
#
# Actions:
#
# Requires:
#
# Sample Usage:
#
# [Remember: No empty lines between comments and class definition]
import "*.pp"
class repositories {
	
	file {"/etc/apt/apt.conf.d/02proxy":
		owner => root,
		group => root,
		mode => 644,
		content => 'Acquire::http { Proxy "http://apt:3142"; };',
	}
	file {"/etc/apt/apt.conf.d/90googleworkaround":
		owner => root,
		group => root,
		mode => 644,
		content => 'Acquire::http::Pipeline-Depth "0";',
	}

	file {"/etc/apt/sources.list":
		owner => root,
		group => root,
		mode => 644,
		source => "puppet:///modules/tomoconnor-repositories/sources.${lsbdistcodename}.list",
	}
}

class repositories::lucid {
	apt::source { "ubuntu_lucid":
            location => "http://archive.ubuntu.com/ubuntu/",
            release => "lucid",
            repos => "main restricted universe multiverse",
            required_packages => "ubuntu-keyring",
        }
        
	apt::source { "ubuntu_lucid_updates":
	            location => "http://archive.ubuntu.com/ubuntu/",
	            release => "lucid-updates",
	            repos => "main restricted universe multiverse",
        }

	apt::source { "ubuntu_lucid_security":
	            location => "http://archive.ubuntu.com/ubuntu/",
	            release => "lucid-security",
	            repos => "main restricted universe multiverse",
        }
        
	apt::source { "ubuntu_lucid_partner":
	            location => "http://archive.canonical.com/",
	            release => "lucid",
	            repos => "partner",
        }
	exec { "repo_apt_update":
                command => "apt-get update",
                subscribe => [ File["/etc/apt/sources.list"] ],
                refreshonly => true,
        }

}

class repositories::precise {
	exec { "repo_apt_update":
                command => "apt-get update",
                subscribe => [ File["/etc/apt/sources.list"] ],
                refreshonly => true,
        }


}
