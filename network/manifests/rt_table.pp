# Definition: network::rt_table
#
# Configures /etc/iproute2/rt_table
#
# Parameters:
#   $weight - required
#
# Actions:
#
# Sample Usage:
#   # source_eth3
#   network::rt_table { 'source_eth3':
#     weight => '200',
#   }
#
define network::rt_table (
  $weight,
  ) {
  include ::network::rt_tables

  $table = $name

  concat::fragment { "network_rt_table_${table}":
    target  => '/etc/iproute2/rt_tables',
    content => "${weight}\t${table}\n",
    order   => $weight,
  }

}
