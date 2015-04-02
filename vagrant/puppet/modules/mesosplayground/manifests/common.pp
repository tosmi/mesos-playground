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
}
