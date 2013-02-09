class nvidia::config {

    #Kinda an empty class now. Should we find a way in which to trigger reboots at the correct time for
    #a new driver then this can be re-enabled.

    exec { "restart_after_nvidia_install" :
        command     => "shutdown -r 1",
        path        => ["/sbin"],
        refreshonly => true,
    }

}
