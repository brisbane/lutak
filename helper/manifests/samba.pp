#
# = Class: helper::samba
#
# This class wraps create_resources around hiera hashes for Samba Shares
class helper::samba {
  include ::samba
  include ::samba::server
  include ::samba::server::restart

  # create samba shares
  create_resources(::samba::server::share, hiera_hash('samba::server::shares',{}))
}
