define php::pear ($ensure="present") {
 $phpprefix = "php-"
  package { "${phpprefix}${name}":
    ensure => $ensure,
  }
}
