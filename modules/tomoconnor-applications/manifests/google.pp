class applications::google{
	package { "google-chrome-stable":
		ensure => latest,
	}
	package { "adobe-flashplugin":
		ensure => latest,
	}
	package {"google-earth-stable":
		ensure => latest,
	}
	package {"google-talkplugin":
		ensure => latest,
	}
}
