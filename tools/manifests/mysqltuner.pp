# Class: tools::mysqltuner
#
# This modules installs mysqltuner
#
class tools::mysqltuner {
  package { 'mysqltuner':
    ensure  => latest,
  }
}
