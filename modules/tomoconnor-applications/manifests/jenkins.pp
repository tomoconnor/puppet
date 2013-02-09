class applications::jenkins {
    /*
    Installs the latest pre-packaged/configured version of jenkins
    from our repo.
    */

    package { "jenkins-ci": ensure => latest, }
}
