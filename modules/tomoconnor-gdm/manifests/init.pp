# Class: gdm
#
# This module manages gdm
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
class gdm {

	package {"gdm": ensure => installed,}
	
	$imgdir = "/usr/share/backgrounds"
	$img  = $lsbdistcodename ? {
		lucid   => "tomoconnor-logo-gdm.png",
		natty   => "tomoconnor-logo-gdm.png",
		default => "tomoconnor-logo-gdm.png",
	}

	$background = "$imgdir/$img"

	file { $background:
		ensure => present,
		source => "puppet:///tomoconnor-gdm/${img}",
		mode => 0644,
		owner => root,
		group => root,
	}

	exec { "gdm_set_background":
		user    => "gdm",
		unless  => "/bin/bash -c 'test `/usr/bin/gconftool-2  -g /desktop/gnome/background/picture_filename`  = \"${background}\"' ",
		command => "/usr/bin/gconftool-2 --type=string --set /desktop/gnome/background/picture_filename \"${background}\" && /usr/bin/gconftool-2 --type=string --set /desktop/gnome/background/picture_options scaled && /usr/bin/gconftool-2 --type=string --set /desktop/gnome/background/primary_color \"#000000\" && /usr/bin/gconftool-2 --type=string --set /desktop/gnome/background/secondary_color \"#000000\" ",
		require => [ File[$background], Package['ubuntu-desktop'], Package['gdm'] ]
	}

#        exec { "gdm_restart_gdm":
#		command => "/sbin/restart gdm",
#		refreshonly => true,
#		subscribe => Exec["gdm_set_background"],
#		require => [ File[$background], Exec['gdm_set_background'], Package['ubuntu-desktop'], Package['gdm'] ],
#	}
#        
	
	service { "gdm": 
		ensure => running, 
		require => [ Package['ubuntu-desktop'], Package['gdm'] ],
	}
	
	
}

