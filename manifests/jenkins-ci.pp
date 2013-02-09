node jenkins inherits genericserver {
    /*
    Virtual server for runnning build recipies
    No nfs mounts are set, these are passed through by openvz
    Inheritance: jenkins <- genericserver <- basenode
    */

    /* repository setup stable is included in basenode */
    include repositories::tomoconnor::unstable

    /* applications setup */
    include applications::java
    include applications::jenkins
    include applications::developertools
    include reepycheep::tools
    include rsyslog
    include rsyslog::remote

    exec { "gem install fpm":
        creates => "/usr/local/bin/fpm",
        timeout => 0,
        require => Package['rubygems'],
    }

    /* dodgy russian proxmox containers */
    package {"language-pack-en-base": ensure => latest,}

    /* purge everything we don't need */
    package {"ubuntu-desktop": ensure => absent,}
    package {"apache2": ensure => absent,}
    package {"apache2-doc": ensure => absent,}
    package {"apache2-mpm-prefork": ensure => absent,}
    package {"apache2-utils": ensure => absent,}
    package {"apache2.2-bin": ensure => absent,}
    package {"apache2.2-common": ensure => absent,}
    package {"sendmail": ensure => absent,}
    package {"sendmail-base": ensure => absent,}
    package {"sendmail-bin": ensure => absent,}
    package {"sendmail-cf": ensure => absent,}
    package {"sendmail-doc": ensure => absent,}
}
