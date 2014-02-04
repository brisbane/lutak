# Class: admintools
#
# This modules installs basic administration utilities
#

class admintools {
  include ::ssh

  package { 'wget':         ensure => latest, }
  package { 'rsync':        ensure => latest, }

  # admin tools
  package { 'nmap':         ensure => latest, }
  package { 'screen':       ensure => latest, }
  package { 'zsh':          ensure => latest, }
  package { 'atop':         ensure => latest, }
  package { 'htop':         ensure => latest, }
  package { 'mutt':         ensure => latest, }
  package { 'iftop':        ensure => latest, }
  package { 'iotop':        ensure => latest, }
  package { 'tcpdump':      ensure => latest, }
  package { 'mc':           ensure => latest, }
  package { 'ncdu':         ensure => latest, }
  package { 'strace':       ensure => latest, }
  package { 'telnet':       ensure => latest, }
  package { 'lsof':         ensure => latest, }
  package { 'expect':       ensure => latest, }

  case $::osfamily {
    default: { }
    /(Debian|debian|Ubuntu|ubuntu)/: {
      package { 'bind9utils':      ensure => latest, }
      package { 'etckeeper':       ensure => latest, }
      package { 'changetrack':     ensure => latest, }
      package { 'apticron':        ensure => latest, }
      package { 'vim':             ensure => latest, }
    }
    /(RedHat|redhat|amazon)/: {
      package { 'bind-utils':      ensure => latest, }
      package { 'vim-enhanced':    ensure => latest, }
    }
  }

  case $::operatingsystem {
    default: { }
    'CentOS' : {
      package { 'man':          ensure => latest, }
    }
    'Fedora' : {
      package { 'man-db':       ensure => latest, }
      package { 'man-pages':    ensure => latest, }
    }
  }
}
