# Class: printing
#
# This module manages printing
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
class printing {

	exec {"/etc/init.d/cups stop":
	}

	file {"/etc/cups/ppd/thirdbase-printer.ppd":
		owner => root,
		group => lp,
		mode => 644,
		source => "puppet:///tomoconnor-printing/thirdbase-printer.ppd",
	}

	file {"/etc/cups/ppd/firstbase-printer.ppd":
		owner => root,
	        group => lp,
	        mode => 644,
	        source => "puppet:///tomoconnor-printing/firstbase-printer.ppd",
	}

	file {"/etc/cups/cupsd.conf":
		owner => root,
                group => lp,
                mode => 644,
                source => "puppet:///tomoconnor-printing/cupsd.conf",
        }
	
	file {"/etc/cups/printers.conf":
		owner => root,
                group => lp,
                mode => 600,
                source => "puppet:///tomoconnor-printing/printers.conf",
        }
	exec {"/etc/init.d/cups start":
        }

	Exec['/etc/init.d/cups stop'] -> File['/etc/cups/ppd/thirdbase-printer.ppd'] -> File['/etc/cups/ppd/firstbase-printer.ppd'] -> File['/etc/cups/cupsd.conf'] -> File['/etc/cups/printers.conf'] -> Exec['/etc/init.d/cups start']

}
