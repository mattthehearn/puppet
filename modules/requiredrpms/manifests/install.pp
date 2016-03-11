class requiredrpms::install {
 
  $pkglist = [ 'telnet', 'nc' ] 
  package { $pkglist:
    ensure => present,
  }
}
