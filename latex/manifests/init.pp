# Class: latex
#
# This modules installs latex
#
class latex {

  package { 'texlive-latex':
    ensure  => present,
  }

}
