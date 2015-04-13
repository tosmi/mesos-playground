require mesosplayground::common

service { 'mesos-master':
  ensure => stopped,
  enable => false,
  require => Package['mesos']
}

service { 'zookeeper':
  ensure => stopped,
  enable => false,
  require => Package['mesosphere-zookeeper']
}

service { 'mesos-slave':
  ensure => running,
  enable => true,
  require => Package['mesos']
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

file { '/etc/default/mesos-slave':
  ensure => present,
  source => 'puppet:///modules/mesosplayground/mesos-slave',
  notify  => Service['mesos-slave']
}

file { '/etc/puppet/puppet.conf':
  ensure => present,
  owner  => puppet,
  group  => puppet,
  source => 'puppet:///modules/mesosplayground/puppet.conf.slave',
}

host { 'puppetmaster':
  ensure       => present,
  ip           => '192.168.50.2',
  host_aliases => 'puppetmaster.stderr.at',
}
