# Class: salt
#
# This module manages salt
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
class salt {
    apt::ppa { "ppa:chris-lea/libpgm": }
    apt::ppa { "ppa:chris-lea/zeromq": }
    apt::ppa { "ppa:saltstack/salt": }
    package {"salt":
        ensure => absent,
    }

    package {"salt-minion":
        ensure => latest,
        require => [ Apt::Ppa["ppa:chris-lea/libpgm"], Apt::Ppa["ppa:chris-lea/zeromq"], Apt::Ppa["ppa:saltstack/salt"] ],

    }

    service {"salt-minion":
        ensure => running,
    }
}
