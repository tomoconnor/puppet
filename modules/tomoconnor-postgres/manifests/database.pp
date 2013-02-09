define postgres::database($ensure, $owner = false) {
  $ownerstring = $owner ? {
    false => "",
    default => "-O $owner"
  }
  case $ensure {
    present: {
      exec{"Create $name postgres db":
        user => "postgres",
        unless => "/usr/bin/psql -l | grep '$name  *|'",
        command => "/usr/bin/createdb $ownerstring $name",
        require => Service[postgresql],
      }
    }
    absent: {
      exec{"Remove $name postgres db":
        user => "postgres",
        onlyif => "/usr/bin/psql -l | grep '$name  *|'",
        command => "/usr/bin/dropdb $name",
        require => Service[postgresql],
      }
    }
    default: {
      fail("Invalid 'ensure' value '$ensure' for postgres::database")
    }
  }
}
