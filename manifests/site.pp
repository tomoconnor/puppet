import "nodes.pp"
import "workstations.pp"
import "servers.pp"
import "jenkins-ci.pp"

import "modules.pp"
import "classes/*.pp"


filebucket { main: server => puppet }
filebucket { local: path => "/var/lib/puppet/clientbucket" }
File { backup => main }
Exec { path => "/bin:/sbin:/usr/bin:/usr/sbin:/usr/local/bin" }

stage {"pre": before => Stage['main']}

stage {"last" : require => Stage['main']}


class main {
}




class prerun {
	#exec {"prerun apt-get update":
#		command => "apt-get update",
#	}
}

