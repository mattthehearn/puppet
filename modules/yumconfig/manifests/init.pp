class yumconfig {
  file { '/etc/yum.repos.d/CentOS-Base.repo':
    ensure => present,
    source => 'puppet:///modules/yumconfig/CentOS-Base.repo',
  }
  file { '/etc/yum.repos.d/CentOS-CR.repo':
    ensure => present,
    source => 'puppet:///modules/yumconfig/CentOS-CR.repo',
  }
  file { '/etc/yum.repos.d/CentOS-Debuginfo.repo':
    ensure => present,
    source => 'puppet:///modules/yumconfig/CentOS-Debuginfo.repo',
  }
  file { '/etc/yum.repos.d/CentOS-fasttrack.repo':
    ensure => present,
    source => 'puppet:///modules/yumconfig/CentOS-fasttrack.repo',
  }
  file { '/etc/yum.repos.d/CentOS-Sources.repo':
    ensure => present,
    source => 'puppet:///modules/yumconfig/CentOS-Sources.repo',
  }
  file { '/etc/yum.repos.d/CentOS-Vault.repo':
    ensure => present,
    source => 'puppet:///modules/yumconfig/CentOS-Vault.repo',
  }
  file { '/etc/yum.repos.d/jenkins.repo':
    ensure => present,
    source => 'puppet:///modules/yumconfig/jenkins.repo',
  }
}
