echo "deb http://apt.puppetlabs.com/ubuntu lucid main" >> /etc/apt/sources.list.d/puppet.list
echo "deb-src http://apt.puppetlabs.com/ubuntu lucid main" >> /etc/apt/sources.list.d/puppet.list

#gpg --recv-key 4BD6EC30
#gpg --recv-key 4BD6EC30
#gpg -a --export 4BD6EC30 | apt-key add -

apt-get update

export LANGUAGE=en_GB.UTF-8
export LANG=en_GB.UTF-8
export LC_ALL=en_GB.UTF-8
locale-gen en_GB.UTF-8
dpkg-reconfigure locales

apt-get install -y puppet puppetmaster ntp
rm -rf /etc/puppet
cd /etc/
git clone ssh://root@git/home/tech/repositories/git/ops/puppet2.git puppet
