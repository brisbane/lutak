# Class: aspell::en
#
# This modules installs aspell-en package
# which provides word list/dictionaries for
# the following: English, Canadian, English,
# British English
#
class aspell::en {
  include ::aspell

  package { 'aspell-en':
    ensure  => present,
  }

}
