define postgres::admin_role( $ensure = present, $password){
  postgres::role { $name:
    password => $password,
    options => "SUPERUSER CREATEDB CREATEROLE",
    ensure => $ensure;
  }
}

