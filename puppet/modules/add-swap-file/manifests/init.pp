class add-swap-file {

  exec { 'create swap':
    command => 'install -o root -g root -m 0600 /dev/null /swapfile',
    path    => "/usr/bin:/usr/sbin:/bin",
  }
  
  exec { 'write swap':
    command => 'dd if=/dev/zero of=/swapfile bs=1k count=2048k',
    path    => "/bin",
    require => Exec[ 'create swap' ],
  }
  
  exec { 'mkswap /swapfile':
    command => 'mkswap /swapfile',
    path    => "/sbin",
    require => Exec[ 'write swap' ],
  }

  exec { 'swapon /swapfile':
    command => 'swapon /swapfile',
    path    => "/sbin",
    require => Exec[ 'mkswap /swapfile' ],
  }
  
  exec { 'add to systable':
    command => 'echo "/swapfile       swap    swap    auto      0       0" | sudo tee -a /etc/fstab',
    path    => "/sbin:/bin:/usr/bin",
    require => Exec[ 'swapon /swapfile' ],
  }
  
  exec { 'increase swapiness':
    command => 'sysctl -w vm.swappiness=10',
    path    => "/sbin:/bin",
    require => Exec[ 'add to systable' ],
  }
  
  exec { 'write to sysctl':
    command => 'echo vm.swappiness = 10 | sudo tee -a /etc/sysctl.conf',
    path    => "/sbin:/etc:/usr/bin:/bin",
    require => Exec[ 'increase swapiness' ],
  }
  
}