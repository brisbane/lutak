# Class: postfix
#
class postfix (
  $interfaces = [ 'all' ],
  $mydestination = [ '$myhostname', 'localhost.$mydomain', 'localhost' ],
  $smtpd_banner = '$myhostname ESMTP $mail_name',
) {
  package { 'postfix':
    ensure  => present,
  }

  service { 'postfix':
    ensure  => running,
    enable  => true,
    require => Package['postfix'],
  }
}
