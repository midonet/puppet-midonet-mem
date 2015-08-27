class midonet_mem::vhost (
  $servername    = $midonet_mem::params::servername,
  $docroot       = $midonet_mem::params::docroot,
  $mem_package   = $midonet_mem::params::mem_package,
  $api_namespace = $midonet_mem::params::api_namespace,
  $api_host      = $midonet_mem::params::api_host,
  $apache_port   = $midonet_mem::params::apache_port,
) inherits midonet_mem::params {

  include ::apache
  include ::apache::mod::headers

  $proxy_pass = [
    { 'path' => "/$api_namespace",
      'url'  => "$api_host",
    },
  ]
  $directories = [
    { 'path'  => '/var/www/html',
      'allow' => 'from all',
    },
  ]

  apache::vhost { 'midonet-mem':
    port            => $apache_port,
    servername      => $servername,
    docroot         => '/var/www/html',
    proxy_pass      => $proxy_pass,
    redirect_source => '/midonet-manager',
    redirect_dest   => $docroot,
    directories     => $directories,
    require         => Package["$mem_package"],
  }

}

