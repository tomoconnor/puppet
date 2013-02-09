class nfs::mount::home {
	mount { "/home":
		device  => "homes-nfs:/home",
		fstype  => "nfs",
		ensure  => "mounted",
		options => "vers=3,proto=tcp,hard,intr,timeo=600,retrans=2,wsize=32768,rsize=32768",
		atboot  => "true",
		blockdevice => '-',
		require => [Class['nfs'],Exec['load-nfs-module']]
       }

}
