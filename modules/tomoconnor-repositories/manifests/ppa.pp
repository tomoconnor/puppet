class repositories::ppa {
	case $lsbdistcodename {
		'lucid': {
				pt::ppa { "ppa:mozillateam/firefox-stable": }
				apt::ppa { "ppa:nginx/stable": }
				apt::ppa { "ppa:ubuntu-x-swat/x-updates": }
				apt::ppa { "ppa:pitti/postgresql": }
			}
		'precise': {
				pt::ppa { "ppa:mozillateam/firefox-stable": }
				apt::ppa { "ppa:nginx/stable": }
				apt::ppa { "ppa:ubuntu-x-swat/x-updates": }
				apt::ppa { "ppa:pitti/postgresql": }
			}

	}
}
