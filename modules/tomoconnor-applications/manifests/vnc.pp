class applications::vnc {
	exec {"vnc_step1":
		user => root,
		unless => "/bin/bash -c 'test `/usr/bin/gconftool-2 --direct --config-source xml:readwrite:/etc/gconf/gconf.xml.mandatory -g /desktop/gnome/remote_access/prompt_enabled` = \"false\"'",
		command => "/usr/bin/gconftool-2 --direct --config-source xml:readwrite:/etc/gconf/gconf.xml.mandatory --type boolean --set /desktop/gnome/remote_access/prompt_enabled false",
	}

	exec {"vnc_step2":
		user => root,
		unless => "/bin/bash -c 'test `/usr/bin/gconftool-2 --direct --config-source xml:readwrite:/etc/gconf/gconf.xml.mandatory -g /desktop/gnome/remote_access/enabled` = \"true\"'",
		command => "/usr/bin/gconftool-2 --direct --config-source xml:readwrite:/etc/gconf/gconf.xml.mandatory --type boolean --set /desktop/gnome/remote_access/enabled true",
	}
	exec {"vnc_step3":
		user => root,
		unless => "/bin/bash -c 'test `/usr/bin/gconftool-2 --direct --config-source xml:readwrite:/etc/gconf/gconf.xml.mandatory -g /desktop/gnome/remote_access/icon_visibility` = \"never\"'",
		command => "/usr/bin/gconftool-2 --direct --config-source xml:readwrite:/etc/gconf/gconf.xml.mandatory --type string --set /desktop/gnome/remote_access/icon_visibility 'never'",
	}
	exec {"vnc_step4":
		user => root,
		unless => "/bin/bash -c 'test `/usr/bin/gconftool-2 --direct --config-source xml:readwrite:/etc/gconf/gconf.xml.mandatory -g /desktop/gnome/remote_access/view_only` = \"true\"'",
		command => "/usr/bin/gconftool-2 --direct --config-source xml:readwrite:/etc/gconf/gconf.xml.mandatory --type boolean --set /desktop/gnome/remote_access/view_only true",
	}
	exec {"vnc_step5":
		user => root,
		unless => "/bin/bash -c 'test `/usr/bin/gconftool-2 --direct --config-source xml:readwrite:/etc/gconf/gconf.xml.mandatory -g /desktop/gnome/remote_access/authentication_methods` = \"[vnc]\"'",
		command => "/usr/bin/gconftool-2 --direct --config-source xml:readwrite:/etc/gconf/gconf.xml.mandatory --type list --list-type string --set /desktop/gnome/remote_access/authentication_methods '[vnc]'",
	}
	exec {"vnc_step6":
		user => root,
		unless => "/bin/bash -c 'test `/usr/bin/gconftool-2 --direct --config-source xml:readwrite:/etc/gconf/gconf.xml.mandatory -g /desktop/gnome/remote_access/vnc_password` = \"eWVsbG93c3VibWFyaW5l\"'",
		command => "/usr/bin/gconftool-2 --direct --config-source xml:readwrite:/etc/gconf/gconf.xml.mandatory --type string --set /desktop/gnome/remote_access/vnc_password 'eWVsbG93c3VibWFyaW5l'",
	}
	exec {"vnc_step7":
		user => root,
		unless => "/bin/bash -c 'test `/usr/bin/gconftool-2 --direct --config-source xml:readwrite:/etc/gconf/gconf.xml.mandatory -g /desktop/gnome/remote_access/use_upnp` = \"false\"'",
		command => "/usr/bin/gconftool-2 --direct --config-source xml:readwrite:/etc/gconf/gconf.xml.mandatory --type boolean --set /desktop/gnome/remote_access/use_upnp false",
	}
	exec {"vnc_step8":
		user => root,
		unless => "/bin/bash -c 'test `/usr/bin/gconftool-2 --direct --config-source xml:readwrite:/etc/gconf/gconf.xml.mandatory -g /desktop/gnome/remote_access/require_encryption` = \"false\"'",
		command => "/usr/bin/gconftool-2 --direct --config-source xml:readwrite:/etc/gconf/gconf.xml.mandatory --type boolean --set /desktop/gnome/remote_access/require_encryption false",
	}

	Exec['vnc_step1'] -> Exec['vnc_step2'] -> Exec['vnc_step3'] -> Exec['vnc_step4'] -> Exec['vnc_step5'] -> Exec['vnc_step6'] -> Exec['vnc_step7'] -> Exec['vnc_step8']


}
