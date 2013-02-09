define postgres::role( $ensure, $options = '', $password = false ) {
  $passtext = $password ? {
    false => "",
    default => "ENCRYPTED PASSWORD '$password'"
  }
  case $ensure {
    present: {
      # The createuser command always prompts for the password.
      exec { "Create $name postgres role":
        user => "postgres",
        unless => "/usr/bin/psql -c '\\du' | grep '^  *$name'",
        command => "/usr/bin/psql -c \"CREATE ROLE $name $options $passtext LOGIN\"",
        require => Service[postgresql],
      }
    }
    absent: {
      exec { "Remove $name postgres role":
        user => "postgres",
        onlyif => "/usr/bin/psql -c '\\du' | grep '$name  *|'",
        command => "/usr/bin/dropuser $name",
        require => Service[postgresql],
      }
    }
    default: {
      fail("Invalid 'ensure' value '$ensure' for postgres::role")
    }
  }
}

