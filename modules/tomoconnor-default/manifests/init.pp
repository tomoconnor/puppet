# Class: ldndefault
#
# This module manages ldndefault - This is effectively a "bootstrap" and installs some interesting stuff that makes life easier.
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
class ldndefault {
	case $lsbdistcodename {
		'lucid':{
			package {"libavcodec-extra-52": ensure => latest,}
			package {"ia32-libs": ensure => latest,}
			package {"gcc-4.3": ensure => "4.3.4-10ubuntu1", }
			package {"lm-sensors": ensure => latest,}
			package {"sensors-applet": ensure => latest,}
			}
		'precise':{
			package {"libavcodec-extra-53": ensure => latest,}
			package {"lm-sensors": ensure => latest,}
			exec {"/usr/bin/apt-get -q -y -o DPkg::Options::=--force-confold install libsane:i386 libgphoto2-2:i386 ia32-libs-multiarch:i386 libgd2-xpm:i386":
				unless => "/usr/bin/dpkg -s ia32-libs-multiarch:i386",
				user => root,
				timeout => 0,
				}
			}
	} #lsbdistcodename
	package {"ethtool": ensure => latest,}
	package {"fing": ensure => latest, }
	package {"dnsutils": ensure => latest,}
	package {"nss-updatedb": ensure => latest,}
	package {"libnss-db": ensure => latest,}
	package {"lsb-core": ensure => latest,}
	package {"tree": ensure => latest,}
	package {"iotop": ensure => latest,}
	package {"debian-keyring": ensure => latest,}
	package {"debian-maintainers": ensure => latest,}
	package {"libncurses5-dev": ensure => latest,}
	package {"unzip": ensure => latest,}
	package {"unrar": ensure => latest,}
	package {"libnotify-bin": ensure => latest,}
	package {"imagemagick": ensure => latest,}
	package {"graphicsmagick": ensure => latest,}
	package {"ffmpeg": ensure => latest,}
	package {"memstat": ensure => latest,}
	package {"lldpd": ensure => latest,}
	package {"logcheck": ensure => latest,}
        package {"build-essential": ensure => latest,}
        package {"dstat": ensure => latest, }

	package {"vlc": ensure => latest,}
	package {"flashplugin-installer": ensure => latest,}
	package {"gstreamer0.10-ffmpeg": ensure => latest,}
	package {"gstreamer0.10-plugins-bad": ensure => latest,}
	package {"filezilla": ensure => latest,}
	package {"libx11-dev": ensure => latest,}
	package {"libxi-dev": ensure => latest,}
	package {"x11proto-input-dev": ensure => latest,}
	package {"xserver-xorg-dev": ensure => latest,}
	package {"tk8.4-dev": ensure => latest,}
	package {"tcl8.4-dev": ensure => latest,}
	package {"keepassx": ensure => latest,}
	package {"transmageddon": ensure => latest,}
	package {"gimp": ensure => latest,}
	package {"nautilus-open-terminal": ensure => latest,}
	package {"xutils-dev": ensure => latest,}
	package {"autoconf": ensure => latest,}
	package {"libtool": ensure => latest,}
	package {"pkg-config": ensure => latest,}
	package {"xserver-xorg-input-wacom": ensure => latest,}
	package {"krename": ensure => latest,}
	package {"lprof": ensure => latest,}
	package {"giggle": ensure => latest,}
	package {"git-cola": ensure => latest,}
	package {"meld": ensure => latest,}
	package {"libgl1-mesa-dri": ensure => latest,}
	package {"libgl1-mesa-glx": ensure => latest,}
	package {"libglw1-mesa": ensure => latest,}
	package {"libice6": ensure => latest,}
	package {"libsm6": ensure => latest,}
	package {"libxdamage1": ensure => latest,}
	package {"libxfixes3": ensure => latest,}
	package {"libxt6": ensure => latest,}
	package {"libxxf86vm1": ensure => latest,}
	package {"x11-common": ensure => latest,}
	package {"libxcursor1": ensure => latest,}
	package {"libxrandr2": ensure => latest,}
	package {"libxrender1": ensure => latest,}
	package {"libglu1-mesa": ensure => latest,}
	package {"fontconfig-config": ensure => latest,}
	package {"libfontconfig1": ensure => latest,}
	package {"libxft2": ensure => latest,}
	package {"ttf-dejavu-core": ensure => latest,}
	package {"libxi6": ensure => latest,}
	package {"libxinerama1": ensure => latest,}
	package {"libxmu6": ensure => latest,}
	package {"debconf-utils": ensure => latest,}
	package {"python-qt4": ensure => latest,}
	package {"python-qt4-dev": ensure =>latest,}
	package {"iftop": ensure => latest, }
	package {"libxp6": ensure => latest, }
	package {"apt-listchanges": ensure => latest, }
	package {"python-git": ensure => latest, }	

	package {"zlibc": ensure => latest,}
	package {["zlib1g", "zlib1g-dev"]: ensure => latest, }
	package {"wrapper-functions": ensure => latest,}
	package {"netcat":
		ensure => latest,
	}	
	package {"strace":
		ensure => latest,
	}
	
	package { "network-manager":
		ensure => purged,
	}
	package {"network-manager-gnome":
		ensure => purged,
	}
	package {"ruby": ensure => latest, }
	package {"screen": ensure => latest, }
	package {"rubygems": ensure => latest,}
	package {"ruby1.8-dev": ensure => latest,}
	package {"python-pip": ensure => latest,}
	package {
		"cron": ensure => present;
		"nano": ensure => present;
		"pwgen": ensure => present;
		"vim": ensure => present;
		"curl": ensure => present;
		"nmap": ensure => present;
		"tshark": ensure => present;
		"iptraf": ensure => present;
		"mtr-tiny": ensure => present;
		"ipcalc": ensure => present;
		"ipython": ensure => present;
		"smartmontools": ensure => present;
		"bzip2": ensure => present;
		"cadaver": ensure => present;
		"tofrodos": ensure => present;
		"lynx": ensure => present;
		"lsof": ensure => present;
		"locales": ensure => present;
	}
	package { ["openssl", "openssh-server", "openssh-client", "openssh-blacklist", "ssl-cert" ]:
		ensure => latest,
	}
	file { "/tmp":
	    ensure => directory,
	    mode   => 1777,
	    owner  => root,
	    group  => root,
	}
	file {"/etc/profile.d":
		ensure => directory,
	}
	
	file {"/etc/update-manager":
		ensure => directory,
		owner => root,
		group => root,
		mode => 755,
	}

	file {"/etc/update-manager/release-upgrades":
		ensure => present,
		owner => root,
		group => root,
		content => "prompt=never\n",
	}
	file {"/etc/profile":
		ensure => present,
		owner => root,
		group => root,
		mode => 644,
		source => "puppet:///tomoconnor-default/etc.profile",
	}
	
	file {"/etc/timezone":
		ensure  => present,
		content => "Europe/London",
		notify => Exec['update-tz'],
  	}
	exec { "update-tz":
	        command => "dpkg-reconfigure --frontend noninteractive tzdata",
		path => "/usr/sbin",
		refreshonly => true,
        }
	file { "/etc/modules":
		ensure => present,
	}


}
