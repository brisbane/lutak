# Class: admin-tools::mysqltuner
#
# This modules installs mysqltuner
#
class admintools::mysqltuner {
  package { 'mysqltuner':
    ensure  => present,
  }
}
