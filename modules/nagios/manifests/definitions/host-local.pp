#
# modules/nagios/manifests/definitions/host-local.pp 
# manage distributed monitoring with nagios
# Copyright (C) 2008 Mathieu Bornoz <mathieu.bornoz@camptocamp.com>
# See LICENSE for the full license granted to you.
#

define nagios::host::local ($ensure=present, $address=false, $nagios_alias=false, $hostgroups=false, $contact_groups=false) {

  nagios_host {$name:
    ensure => $ensure,
    use => "generic-host-active",
    address => $address ? {false => $ipaddress, default => $address},
    alias => $nagios_alias ? {false => undef, default => $nagios_alias},
    hostgroups => $hostgroups ? {false => undef, default => $hostgroups},
    contact_groups => $contact_groups ? {false => undef, default => $contact_groups},
    target => "$nagios_cfg_dir/hosts.cfg",
    notify => Exec["nagios-reload"],
    require => File["$nagios_cfg_dir/hosts.cfg"],
  }

}
