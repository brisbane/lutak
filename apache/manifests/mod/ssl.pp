class apache::mod::ssl (
  $sslports = ['443'],
) {
  apache::mod { 'ssl': }
  file { '/etc/httpd/conf.d/ssl.conf':
    ensure  => file,
    owner   => root,
    group   => root,
    mode    => '0644',
    content => template('apache/mod/ssl.conf.erb'),
    notify  => Service['httpd'],
  }
}
