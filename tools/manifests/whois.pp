#
# = Class: tools::whois
#
# Install Whois
#
class tools::whois {

  package { 'jwhois': ensure => present, }

}
