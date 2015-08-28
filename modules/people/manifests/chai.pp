include people::chai::applications
include android::sdk
include android::ndk
include android::tools
include android::platform_tools
include android::studio


class people::chai {

  notify { 'class people::chai declared': }

  ##################################
  ## Facter, Puppet, and Envpuppet##
  ##################################

  repository { "${::boxen_srcdir}/puppet":
    source => 'puppetlabs/puppet',
  }

  repository { "${::boxen_srcdir}/facter":
    source => 'puppetlabs/facter',
  }

  file { '/bin/envpuppet':
    ensure  => link,
    mode    => '0755',
    target  => "${::boxen_srcdir}/puppet/ext/envpuppet",
    require => Repository["${::boxen_srcdir}/puppet"],
  }



  android::version{ '22':
      options => ['add_on', 'system_image', 'sample']
      }

  android::build_tools{'22':}




}
