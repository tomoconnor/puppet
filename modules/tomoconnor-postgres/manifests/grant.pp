define postgres::grant(
  $ensure,
  $owner,
  $database = "all",
  $options  = "all privileges"
) {
  $passtext = $password ? {
    false => "",
    default => "ENCRYPTED PASSWORD '$password'"
  }
  case $ensure {
    present: {
      # The createuser command always prompts for the password.
      exec { "grant $name postgres ":
        user => "postgres",
#        unless => "/usr/bin/psql -c '\\du' | grep '^  *$name'",
        command => "/usr/bin/psql -c \"grant $options on database $database to $owner\"", 
        require => Service[postgresql],
      }
    }
    absent: {
      exec { "revoke $name postgres":
        user => "postgres",
#        onlyif => "/usr/bin/psql -c '\\du' | grep '$name  *|'",
        command => "/usr/bin/psql -c \"revoke $options on database $database to $owner\"", 
        require => Service[postgresql],
      }
    }
    default: {
      fail("Invalid 'ensure' value '$ensure' for postgres::grant")
    }
  }
}
