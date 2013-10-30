# Class: admintools
#
# This modules installs basic administration utilities
#

class admintools {
  # centos 6 minimal
  package { 'openssh-clients': ensure => latest }
  package { 'wget':            ensure => latest, }
  package { 'rsync':           ensure => latest, }
  package { 'bind-utils':      ensure => latest, }
  # admin tools
  package { 'nmap':         ensure => latest, }
  package { 'screen':       ensure => latest, }
  package { 'zsh':          ensure => latest, }
  package { 'atop':         ensure => latest, }
  package { 'htop':         ensure => latest, }
  package { 'mutt':         ensure => latest, }
  include ::tools::vim
  package { 'iftop':        ensure => latest, }
  package { 'iotop':        ensure => latest, }
  package { 'tcpdump':      ensure => latest, }
  package { 'mc':           ensure => latest, }
  package { 'ncdu':         ensure => latest, }
  package { 'strace':       ensure => latest, }
  package { 'telnet':       ensure => latest, }
  package { 'lsof':         ensure => latest, }
  package { 'expect':       ensure => latest, }

  case $::operatingsystem {
    default: {
      package { 'man':          ensure => latest, }
    }
    'CentOS' : {
      package { 'man':          ensure => latest, }
    }
    'Fedora' : {
      package { 'man-db':       ensure => latest, }
      package { 'man-pages':    ensure => latest, }
    }
  }
}
