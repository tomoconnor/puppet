import "*.pp"
import "*/*.pp"
class php {
      $phpini = "/etc/php5/cli/php.ini"
      $phpinidir = "/etc/php5/conf.d/"

      include php::debian
    
}
