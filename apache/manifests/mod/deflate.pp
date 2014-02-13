# Class: apache::mod::deflate
class apache::mod::deflate {
  apache::mod { 'deflate': }
  file { '/etc/httpd/conf.d/deflate.conf':
    ensure  => file,
    owner   => root,
    group   => root,
    mode    => '0644',
    source  => 'puppet:///modules/apache/deflate.conf',
    notify  => Service['httpd'],
    require => Package['httpd'],
  }
}
