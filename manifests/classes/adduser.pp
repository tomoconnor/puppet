define add_user ( $name, $uid, $password, $shell, $groups, $sshkeytype, $sshkey) {

 $homedir = $kernel ? {
  'SunOS' => '/export/home',
  default   => '/home'
 }
 
 $username = $title
 user { $username:
  comment => "$name",
  home    => "$homedir/$username",
  shell   => "$shell",
  uid     => $uid,
  gid => $uid,
  managehome => 'true',
  password  => "$password",
  groups => $groups
 }

 group { $username:
  gid => "$uid"
 }

 ssh_authorized_key{ $username: 
  user => "$username",
  ensure => present, 
  type => "$sshkeytype", 
  key => "$sshkey", 
  name => "$username" 
 } 
}
