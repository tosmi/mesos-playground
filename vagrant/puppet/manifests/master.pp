require mesosplayground::common

service { 'zookeeper':
  ensure  => running,
  enable  => true,
  require => Package['mesosphere-zookeeper']
}

service { 'mesos-master':
  ensure  => running,
  enable  => true,
  require => Package['mesos']
}

service {'marathon':
  ensure  => running,
  enable  => true,
  require => Package['marathon']
}

file { '/etc/default/mesos-master':
  ensure => present,
  source => 'puppet:///modules/mesosplayground/mesos-master',
  notify => Service['mesos-master']
}

yumrepo { 'jenkins':
  ensure  => present,
  enabled => true,
  baseurl => 'http://pkg.jenkins-ci.org/redhat',
  gpgcheck => 0,
} ->
package { 'jenkins':
  ensure => installed,
} ->
service { 'jenkins':
  ensure => running,
  enabled => true,
}
