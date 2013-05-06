# Define: samba::server::winbind
define samba::server::share (
  $path,
  $comment             = '',
  $valid_users         = '',
  $force_user          = '',
  $force_group         = '',
  $browseable          = 'yes',
  $writeable           = 'yes',
  $force_mode          = '',
  $force_dir_mode      = '',
  $force_security_mode = '',
  $guest_ok            = 'no',
  $guest_only          = 'no',
  $delete_readonly     = '',
) {

  concat::fragment { "smb_conf:${name}":
    target  => '/etc/samba/smb.conf',
    content => template('samba/share.erb'),
    order   => '200',
  }

}
