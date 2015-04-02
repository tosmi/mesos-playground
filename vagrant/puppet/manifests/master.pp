service { 'zookeeper':
  ensure => running,
  enable => true,
}

service { 'mesos-master':
  ensure => running,
  enable => true,
}

file { '/etc/default/mesos-master':
  ensure => present,
  source => 'puppet:///modules/mesosplayground/mesos-master'
  notify  => Service['mesos-master']
}

include mesosplayground::common
