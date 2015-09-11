class system-update {

  exec { 'apt-get update':
    command => 'apt-get update',
    path    => "/usr/bin:/usr/sbin:/bin",
  }
  
  $sysPackages = [ "build-essential", "lxc", "wget", "bsdtar"]
  package { $sysPackages:
    ensure  => "installed",
    require => Exec['apt-get update'],
  }
  
  exec { 'modprobe aufs':
    command => 'modprobe aufs',
    path    => "/sbin",
    require => Package[ $sysPackages ],
  }
  
  package { git:
    ensure   => "installed",
    provider => "apt",
  }
}