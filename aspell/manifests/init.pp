# Class: aspell
#
# This modules installs aspell
#
class aspell {

  package { 'aspell':
    ensure  => present,
  }

}
