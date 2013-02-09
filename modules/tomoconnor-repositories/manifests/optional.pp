class repositories::optional {
	apt::source { "dropbox_ubuntu_lucid":
	            location => "http://linux.dropbox.com/ubuntu",
	            release => "lucid",
		    include_src => false,
	            repos => "main",
	            key => "5044912E",
	            key_server => "pgp.mit.edu",
	}
	file { [ "/etc/apt/sources.list.d/dropbox.list", "/etc/apt/sources.list.d/dropbox.list.save"] :
		ensure => absent,
	}

	apt::source { "google-chrome":
	            location => "http://dl.google.com/linux/chrome/deb/",
	            release => "stable",
		    include_src => false,
	            repos => "main",
	            key => "7FAC5991",
	            key_server => "subkeys.pgp.net",
	}
	file { [ "/etc/apt/sources.list.d/google_chrome.list", "/etc/apt/sources.list.d/google_chrome.list.save"] :
                ensure => absent,
        }

	apt::source { "google-earth":
	            location => "http://dl.google.com/linux/earth/deb/",
	            release => "stable",
	            repos => "main",
		    include_src => false,
	}
	file { [ "/etc/apt/sources.list.d/google_earth.list", "/etc/apt/sources.list.d/google_earth.list.save"] :
                ensure => absent,
        }


	apt::source { "google-talkplugin":
	            location => "http://dl.google.com/linux/talkplugin/deb/",
	            release => "stable",
		    include_src => false,
	            repos => "main",
	}
	file { [ "/etc/apt/sources.list.d/google_talk.list", "/etc/apt/sources.list.d/google_talk.list.save"] :
                ensure => absent,
        }


	file { [ "/etc/apt/sources.list.d/virtualbox.list", "/etc/apt/sources.list.d/virtualbox.list.save"] :
                ensure => absent,
        }

	apt::source { "spotify":
	            location => "http://repository.spotify.com/",
	            release => "stable",
	            repos => "non-free",
		    include_src => false,
	            key => "94558F59",
	            key_server => "minsky.surfnet.nl",
	}
	file { [ "/etc/apt/sources.list.d/webupd8team-java-lucid.list", "/etc/apt/sources.list.d/webupd8team-java-lucid.list.save"] :
                ensure => absent,
        }

	

}
