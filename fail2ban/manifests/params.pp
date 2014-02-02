# Class: fail2ban::params
class fail2ban::params {
  $global_ignore   = [ $::ipaddress ]
  $global_bantime  = 60000
  $global_maxretry = 3
}
