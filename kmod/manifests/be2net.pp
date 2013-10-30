# Class: kmod::be2net
class kmod::be2net {
  include yum::repo::elrepo

  # kernel modules for correct tcpdump
  package {'kmod-be2net': ensure  => present, }
}
