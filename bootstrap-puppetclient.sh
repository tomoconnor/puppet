echo "deb http://apt.puppetlabs.com/ubuntu lucid main" >> /etc/apt/sources.list.d/puppet.list
echo "deb-src http://apt.puppetlabs.com/ubuntu lucid main" >> /etc/apt/sources.list.d/puppet.list

echo "192.168.123.141 puppet-2.london.tomoconnor.eu puppet-2" >> /etc/hosts
#gpg --recv-key 4BD6EC30
#gpg --recv-key 4BD6EC30
#gpg -a --export 4BD6EC30 | apt-key add -
apt-key adv --keyserver keyserver.ubuntu.com --recv-keys 4BD6EC30 1054B7A24BD6EC30
apt-get update
export LANGUAGE=en_GB.UTF-8
export LANG=en_GB.UTF-8
export LC_ALL=en_GB.UTF-8
locale-gen en_GB.UTF-8
dpkg-reconfigure locales

apt-get install -y puppet
puppetd --test --server puppet-2.london.tomoconnor.eu --waitforcert 30
