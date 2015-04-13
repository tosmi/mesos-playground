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


###############
# Jenkins setup
#
yumrepo { 'jenkins':
  ensure  => present,
  enabled => true,
  baseurl => 'http://pkg.jenkins-ci.org/redhat',
  gpgcheck => 0,
} ->
package { 'jenkins':
  ensure => installed,
} ->
file { '/etc/sysconfig/jenkins':
  ensure => present,
  source => 'puppet:///modules/mesosplayground/jenkins',
  notify => Service['jenkins'],
}

service { 'jenkins':
  ensure => running,
  enable => true,
}

package { 'haproxy':
  ensure => installed,
} ->
file { '/etc/haproxy/haproxy.cfg':
  ensure => present,
  mode   => 644,
  owner  => root,
  group  => root,
  source => 'puppet:///modules/mesosplayground/haproxy.cfg',
}
