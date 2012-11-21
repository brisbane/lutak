class fail2ban::params {
  $global_ignore   = [ '127.0.0.1/8' ]
  $global_bantime  = 60000
  $global_maxretry = 3
}
