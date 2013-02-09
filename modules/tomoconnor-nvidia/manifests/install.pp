class nvidia::install {

    # we ensure that the package is installed and then held so that no
    # further updates occur without our explicit choice.
    package { "nvidia-current":
        ensure  => latest,
    }

    exec { "enable_current_nvidia_driver" :
        command     => "nvidia-xconfig",
        creates     => "/etc/X11/xorg.conf",
        path        => ["/usr/bin", "/sbin"],
    }
}

