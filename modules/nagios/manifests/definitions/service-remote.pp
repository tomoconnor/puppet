#
# modules/nagios/manifests/definitions/service-remote.pp 
# manage distributed monitoring with nagios
# Copyright (C) 2008 Mathieu Bornoz <mathieu.bornoz@camptocamp.com>
# See LICENSE for the full license granted to you.
#

define nagios::service::remote ($ensure=present, $service_description=false) {

  @@nagios_service {"@@$name on $hostname":                
    ensure                => $ensure,
    use                   => "generic-service-passive",
    host_name             => $hostname,
    tag                   => "nagios",
    service_description   => $service_description ? {false => undef, default => $service_description},
    target                => "$nagios_cfg_dir/services.cfg",
    require               => File["$nagios_cfg_dir/services.cfg"],
    notify                => Exec["nagios-reload"],
  }
}
