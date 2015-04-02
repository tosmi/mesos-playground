service { 'zookeeper':
  ensure => running,
  enable => true,
}

service { 'mesos-master':
  ensure => running,
  enable => true,
}

include mesosplayground::common
