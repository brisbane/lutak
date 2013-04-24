# Class: apache::mod::extract_forwarded
class apache::mod::extract_forwarded (
  $mef_order  = 'refuse,accept',
  $mef_refuse = [ 'all' ],
  $mef_accept = [ '127.0.0.1', $::ipaddress ],
  $mef_addenv = 'on',
  $mef_debug  = 'off',
){
  Class['apache::mod::proxy_http'] -> Class['apache::mod::extract_forwarded']
  apache::mod { 'extract_forwarded': }

  file { '/etc/httpd/conf.d/mod_extract_forwarded.conf':
    ensure  => file,
    owner   => root,
    group   => root,
    mode    => '0644',
    content => template('apache/mod/extract_forwarded.conf.erb'),
    notify  => Service['httpd'],
  }
}
