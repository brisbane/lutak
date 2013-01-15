# Class: nfs
#
# This module manages NFS
#
class nfs {
  include nfs::rpcbind
  include nfs::nfslock
}
