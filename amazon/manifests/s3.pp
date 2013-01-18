# Class: amazon::s3
#
# This module manages S3 tools
# (http://s3tools.org)
#
class amazon::s3 {
  require yum::repo::s3tools
  require python::mod::hashlib
  package {'s3cmd':     ensure => present, }
  package {'fuse-s3fs': ensure => present, }
}
