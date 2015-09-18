class midonet_mem::vhost (
  $apache_port = $midonet_mem::params::apache_port,
  $servername  = $midonet_mem::params::servername,
  $docroot     = $midonet_mem::params::docroot,
  $proxy_pass = [
    { 'path' => "/$midonet_mem::params::api_namespace",
      'url'  => "$midonet_mem::params::api_host",
    },
  ],
  $directories = [
    { 'path'  => $docroot,
      'allow' => 'from all',
    },
  ],
) inherits midonet_mem::params {

  include ::apache
  include ::apache::mod::headers

  apache::vhost { 'midonet-mem':
    port            => $apache_port,
    servername      => $servername,
    docroot         => $docroot,
    proxy_pass      => $proxy_pass,
    directories     => $directories,
    require         => Package["$midonet_mem::params::mem_package"],
  }

}

