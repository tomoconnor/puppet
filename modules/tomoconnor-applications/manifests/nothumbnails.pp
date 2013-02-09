class applications::nothumbnails {
	exec {"gconf_nothumbnails":
		user => root,
		unless => "/bin/bash -c 'test `/usr/bin/gconftool-2 --direct --config-source xml:readwrite:/etc/gconf/gconf.xml.mandatory -g /apps/nautilus/preferences/thumbnail_limit` = 1'",
		command => "/usr/bin/gconftool-2 --direct --config-source xml:readwrite:/etc/gconf/gconf.xml.mandatory --type int --set /apps/nautilus/preferences/thumbnail_limit 1",
	}

}



	
