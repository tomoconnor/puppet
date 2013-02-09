class ssd::partition{
	if $ssd_sdb == "true" {
		info("We've found sdb")
		if $partitions_sdb != "sdb1" {
			info("Creating new partition to span /dev/sdb")

			exec {"createPartition":
				command => "echo '0,${ssd_cylmax_sdb},L' | sfdisk -L -q -N1 /dev/sdb",
				provider => shell,
			}

			info("Creating XFS filesystem on /dev/sdb1")
			exec {"createFilesystem":
				command => "/sbin/mkfs.xfs -f /dev/sdb1",
				require => Exec['createPartition'],
			}
			
		} else {
			err("Partitions found on SDB?")
		}
	
	} else {
		err("SDB not a SSD?")
	}
}
