define users::lookupkey($ensure = present) {
    # get keys from hiera, stored in sshkey_username arrays
    $data = hiera("sshkey_${name}")
    # split single key into array
    $data_array = split($data, ' ')

    # if array is =4, then we have options
    case array_length($data) {
      4: {       $options = $data_array[0]
                 $type    = $data_array[1]
                 $key     = $data_array[2]
                 $comment = $data_array[3] }
      default: { $options = absent
                 $type    = $data_array[1]
                 $key     = $data_array[2]
                 $comment = $data_array[3] }
    }

#     $type = array_index($data, "-3")
#     $key = array_index($data, "-2")
#     $comment = array_index($data, "-1")
#     $rest = array_slice($data, 0, "-4")
#     $options = array_length($rest) ? {
#         0       => absent,
#         default => $rest,
#     }

    ssh_authorized_key { "${name}_${comment}":
        ensure  => $ensure,
        key     => $key,
        type    => $type,
        user    => $name,
        options => $options,
        require => [ User[$name], File["/home/${name}/.ssh"], ],
    }
}

# vi:syntax=puppet:filetype=puppet:ts=4:et:
