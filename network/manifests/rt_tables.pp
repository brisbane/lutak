# Class: network::rt_tables
#
# Configures /etc/iproute2/rt_table
#
class network::rt_tables {

  concat { '/etc/iproute2/rt_tables':
    owner   => 'root',
    group   => 'root',
    mode    => '0644',
  }

  concat::fragment { 'network_rt_table_header':
    target => '/etc/iproute2/rt_tables',
    source => 'puppet:///modules/network/rt_tables.base',
    order  => '0',
  }


}
