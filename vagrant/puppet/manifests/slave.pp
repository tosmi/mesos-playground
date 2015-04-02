service { 'mesos-master':
  ensure => stopped,
  enable => false,
}

service { 'zookeeper':
  ensure => stopped,
  enable => false,
}

file { '/etc/mesos/zk':
  ensure => present,
  source => 'puppet:///modules/mesosplayground/zk.slave',
}

include mesosplayground::common
