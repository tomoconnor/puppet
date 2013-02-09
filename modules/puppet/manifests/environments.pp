#
# == Class: puppet::environments
#
# This class simply sets the environment list defined by Puppet::Environment[]
# instances. It doesn't really make sense to include this class directly, as
# it's already included in definitions/puppet-environment.pp.
#
class puppet::environments {

  puppet::config { "main/environments":
    value => all_puppet_environments(),
  }
}
