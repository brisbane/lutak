# Class: admin-tools::mysqltuner
#
# This modules installs mysqltuner
#
class admintools::mysqltuner {
  require yum::repo::epel
  package { 'mysqltuner':
    ensure  => latest,
  }
}
