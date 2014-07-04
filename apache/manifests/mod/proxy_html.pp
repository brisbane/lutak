# = Class: apache::mod::proxy_html
class apache::mod::proxy_html {
  Class['apache::mod::proxy'] -> Class['apache::mod::proxy_html']
  Class['apache::mod::proxy_http'] -> Class['apache::mod::proxy_html']
  apache::mod { 'proxy_html': }
  # proxy_html uses libxml2 so we need to load this .so
  case $::architecture {
    'x86_64':  { $libdir = '/usr/lib64/' }
    'amd64':   { $libdir = '/usr/lib64/' }
    default:   { $libdir = '/usr/lib/' }
  }
  file { "${::apache::params::mod_dir}/libxml2.load":
    ensure  => present,
    content => "LoadFile ${libdir}libxml2.so.2\n",
  }
}
