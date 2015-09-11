# == Class: discourse
#
# Full description of class discourse here.
#
# === Parameters
#
# Document parameters here.
#
# [*sample_parameter*]
#   Explanation of what this parameter affects and what it defaults to.
#   e.g. "Specify one or more upstream ntp servers as an array."
#
# === Variables
#
# Here you should define a list of variables that this module would require.
#
# [*sample_variable*]
#   Explanation of how this variable affects the funtion of this class and if
#   it has a default. e.g. "The parameter enc_ntp_servers must be set by the
#   External Node Classifier as a comma separated list of hostnames." (Note,
#   global variables should be avoided in favor of class parameters as
#   of Puppet 2.6.)
#
# === Examples
#
#  class { discourse:
#    servers => [ 'pool.ntp.org', 'ntp.local.company.com' ],
#  }
#
# === Authors
#
# Author Name <author@domain.com>
#
# === Copyright
#
# Copyright 2015 Your name here, unless otherwise noted.
#
class discourse {
  include docker
  
  exec { 'create discourse dir':
    command => 'mkdir /var/discourse',
    path    => "/usr/bin:/usr/sbin:/bin",
  }
  
  exec { 'clone discour dir':
    command => 'git clone https://github.com/discourse/discourse_docker.git /var/discourse',
    path    => "/usr/bin:/usr/sbin:/bin",
    require => Package[ 'git' ],
  }
}