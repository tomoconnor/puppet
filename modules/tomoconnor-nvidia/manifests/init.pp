# Class: nvidia
#
# This module manages nvidia
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
class nvidia {
	notice ("$operatingsystem ::: $is_virtual  ")

	case $operatingsystem {
		'Ubuntu','debian': {
			if $is_virtual == "true" {
				err("nvidia class will not run on VMs")

			} else {
                		notice("nvidia class will run on a Physical host")

		                class { 'nvidia::install': }
		                class { 'nvidia::config': stage => "last"}
            		}

        	}
        	default: {
            		err("nvidia_current class only knows about Debian-deriven systems.")
	       		err("${fqdn} runs ${operatingsystem}")
        	}
    	}
}

	

