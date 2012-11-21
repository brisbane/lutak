class apache::mod::extract_forwarded {
  Class['apache::mod::proxy_http'] -> Class['apache::mod::extract_forwarded']
  apache::mod { 'extract_forwarded': }
}
