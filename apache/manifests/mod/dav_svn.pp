# = Class: apache::mod::dav_svn
class apache::mod::dav_svn {
  Class['apache::mod::dav'] -> Class['apache::mod::dav_svn']
  apache::mod { 'dav_svn': }
}
