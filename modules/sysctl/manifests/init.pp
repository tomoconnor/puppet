class sysctl {

    package { "procps":
        ensure => latest,
    }

    define set ($value) {

        augeas { "sysctl conf $name":
            context => "/files/etc/sysctl.conf",
            changes => [
                "set $name $value",
            ],
        }

        exec { "sysctl live $name":
            command     => "/sbin/sysctl -w $name=$value",
            subscribe   => Augeas["sysctl conf $name"],
            refreshonly => true,
        }
    }

}
