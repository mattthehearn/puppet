class requiredrpms::install {
 
  $pkglist = [ 'telnet', 'nc', 'jwhois' ] 
  package { $pkglist:
    ensure => present,
  }
}
