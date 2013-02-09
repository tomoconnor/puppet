class desktop {
	package { "ubuntu-desktop":
		ensure => installed
	}
	package {"mysql-admin":
		ensure => installed
	}
	package {"mysql-query-browser":
		ensure => installed
	}
	package {"mysql-gui-tools-common":
		ensure => installed
	}
	package {"rapidsvn":
		ensure => installed
	}
	package {"svn-workbench":
		ensure => installed
	}
		

	#package {["java-common","sun-java6-bin","sun-java6-fonts","sun-java6-jdk","sun-java6-jre","sun-java6-plugin","sun-java6-source"]:
	package {"java-common":
		ensure => installed,
	}

}

