class nfs::mount {
	case $virtual{
		'openvzve':	{ err("Open VZ VMs do not support nfs")}
		default	: {
				include nfs::mount::home
				include nfs::mount::shows
		}
	}
}		
