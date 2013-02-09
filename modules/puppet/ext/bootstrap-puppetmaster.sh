#!/bin/bash -x

#
# This script sets up a basic puppetmaster on debian/ubuntu
#

MASTER_NAME="puppet"
ENVIRONMENT="stable"
REPO="/srv/puppetmaster/${ENVIRONMENT}"
CA="/srv/puppetca"
TMPDIR=$(mktemp -d)

(apt-get update && apt-get -y install lsb-release facter puppet git) || exit 1
mkdir -p "${TMPDIR}/modules"
git clone http://github.com/camptocamp/puppet-puppet.git "${TMPDIR}/modules/puppet"

mkdir -p $CA $REPO/{manifests,modules,site-modules}

cd $REPO && git init .

test -e $REPO/manifests/site.pp || \
cat << EOF > $REPO/manifests/site.pp
node default {
  fail ("

    Hello, you can start editing your puppet manifests in ${REPO}.
    Have fun !

")
}
EOF

cat << EOF | puppet apply --verbose --modulepath $TMPDIR/modules

  \$puppet_server = "$MASTER_NAME"

  include puppet::client::base
  include puppet::master::webrick

  host { "$MASTER_NAME": ip => "127.0.0.2" }

  Puppet::Config { notify => Service["puppetmaster"] }

  puppet::config {
    "ca/ssldir":          value => "$CA";
    "master/ssldir":      value => "$CA";
    "master/certname":    value => "$MASTER_NAME";
    "main/environments":  value => "$ENVIRONMENT";
    "stable/modulepath":  value => "$REPO/modules:$REPO/site-modules";
    "stable/manifestdir": value => "$REPO/manifests";
    "stable/manifest":    value => "$REPO/manifests/site.pp";
  }
EOF

find /var/lib/puppet/ssl -delete
puppet agent --test
puppetca --sign $(hostname --fqdn)
puppet agent --test --environment $ENVIRONMENT
