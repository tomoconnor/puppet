# Class: nfs
#
# This module manages nfs
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
class nfs {
	case $virtual {
		'openvzve':	{ 
					err("Proxmox VMs do not support nfs")
		} #case openvzve

		default	:	{
					package {"nfs-common":
						ensure => installed,
					}
					case $lsbdistcodename {
						'lucid':	{
							package {"portmap":
								ensure => installed,
							}
							service {"portmap":
								ensure => running,
								enable => true,
								hasstatus => true,
								require => [ Package['portmap'], File["/etc/init/portmap.conf"] ],
							}
							file { "/etc/init/portmap.conf":
								source => "puppet:///modules/tomoconnor-nfs/portmap.conf",
								owner => root,
								group => root,
								mode => 644,
							}
						} #lucid
	
						'oneiric':	{

							package {"rpcbind":
								ensure => installed,
							}
							file {"/etc/init.d/rpcbind":
								source => "puppet:///modules/tomoconnor-nfs/rpcbind.initd",
								owner => root,
								group => root,
								mode => 755,
							}
							service {"rpcbind":
								ensure => running,
								enable => true,
								hasstatus => true,
								require => [ Package['rpcbind'], File['/etc/init.d/rpcbind']]
							}
						} #oneiric	
					} #lsbdistcodename
			

					exec { "load-nfs-module":
						command => "/sbin/modprobe nfs",
						user => root,
						require => Package['nfs-common'],
					}
				} # case default
	} # select case virtual?
} #class
