service { 'mesos-master':
  ensure => stopped,
  enable => false,
}

service { 'zookeeper':
  ensure => stopped,
  enable => false,
}

service { 'mesos-slave':
  ensure => running,
  enable => true,
}

file { '/etc/mesos-slave/containerizers':
  ensure  => present,
  content => 'docker,mesos',
  notify  => Service['mesos-slave']
}

file { '/etc/mesos-slave/executor_registration_timeout':
  ensure => present,
  content => '5mins',
  notify  => Service['mesos-slave']
}

include mesosplayground::common
