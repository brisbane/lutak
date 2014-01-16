# Class: kmod::nvidia::304xx
class kmod::nvidia::304xx {
  include ::yum::repo::elrepo

  # kernel modules for correct tcpdump
  package {'kmod-nvidia-304xx': ensure  => present, }
}
