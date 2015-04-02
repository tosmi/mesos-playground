class mesosplayground::common {
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

  package { 'docker':
    ensure => installed,
  }

  service { 'firewald':
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
}
