# Class: virtualbox::extensionpack
#
# This module installs VirtualBox Extension Pack
#
class virtualbox::extensionpack {
  require virtualbox

  $vboxepack="Oracle_VM_VirtualBox_Extension_Pack-${::virtualbox_version}-${::virtualbox_build}.vbox-extpack"

  exec { 'install_vbox_extensionpack':
    command => "/usr/bin/wget http://download.virtualbox.org/virtualbox/${::virtualbox_version}/${vboxepack} && \
                /usr/bin/VBoxManage extpack install --replace ${vboxepack} && /bin/rm -f ${vboxepack}",
    cwd     => '/tmp',
    unless  => "/usr/bin/VBoxManage list extpacks | /bin/grep 'Revision.*${::virtualbox_build}' > /dev/null 2>&1",
  }

}
