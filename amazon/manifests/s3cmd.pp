# Class: amazon::s3cmd
#
# This module manages S3 tools
# (http://s3tools.org)
#
class amazon::s3cmd {
  require yum::repo::s3tools
  package {'s3cmd':     ensure => present, }
}
