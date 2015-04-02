class mesosplayground::common {

  Package {
    allow_virtual => false,
  }

  package { 'mesosphere-el-repo':
    ensure   => installed,
    source   => 'http://repos.mesosphere.io/el/7/noarch/RPMS/mesosphere-el-repo-7-1.noarch.rpm',
    provider => 'rpm',
  } ->
  package { 'mesos':
    ensure => installed,
  } ->
  package { 'marathon':
    ensure => installed,
  }
  package { 'mesosphere-zookeeper':
    ensure => installed,
  }

  # there was a problem starting docker with an older
  # version of device-mapper, so always use the latest
  # and greatest
  package { 'device-mapper':
    ensure => latest,
  } ->
  package { 'docker':
    ensure => installed,
  } ->
  file { '/etc/sysconfig/docker':
    ensure => file,
    source => 'puppet:///modules/mesosplayground/docker',
    notify => Service['docker']
  }

  service { 'docker':
    ensure => running,
    enable => true,
  }

  # used for testing
  package { 'telnet':
    ensure => installed,
  }

  service { 'firewalld':
    ensure => stopped,
    enable => false,
  }

  host { 'master':
    ensure => present,
    ip     => '192.168.50.2',
  }

  host { 'slave1':
    ensure => present,
    ip     => '192.168.50.3',
  }

  host { 'slave2':
    ensure => present,
    ip     => '192.168.50.4',
  }

  file { '/etc/mesos/zk':
    ensure  => present,
    source  => 'puppet:///modules/mesosplayground/zk.slave',
    require => [ Package['mesos'], Host['master'], ],
    notify  => Service['mesos-master']
  }
}
