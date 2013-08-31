# Class: postfix
#
class postfix (
  $manage_maincf = true,
  $interfaces    = [ 'localhost' ],
  $mydestination = [ '$myhostname', 'localhost.$mydomain', 'localhost' ],
  $smtpd_banner  = '$myhostname ESMTP $mail_name',
  $relayhost     = '',
  ) {

  File {
    ensure => file,
    owner  => root,
    group  => root,
    mode   => '0644',
    notify => Service['postfix'],
  }

  package { 'postfix':
    ensure  => present,
  }

  service { 'postfix':
    ensure  => running,
    enable  => true,
    require => Package['postfix'],
  }

  if $manage_maincf == true {
    file { '/etc/postfix/main.cf':
      content => template('postfix/main.cf.erb'),
      notify  => Service['postfix'],
    }
  }

}
