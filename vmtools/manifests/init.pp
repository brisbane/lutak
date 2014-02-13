# Class: vmtools
#
# Installs the Vm tools, depending on type of virtualization
class vmtools {
  case $::virtual {
    default:    {}
    /^xen*/:    { include ::vmtools::xen }
    /^vmware$/: { include ::vmwaretools  }
  }
}
