# Add stlib for android
# Add java for android

require stdlib
require java


include people::chai::applications
include dropbox
include googledrive

include android::sdk
include android::ndk
include android::tools
include android::platform_tools
include android::build_tools
include android::studio


class people::chai {

  notify { 'class people::chai declared': }

  # Changes the default shell to the zsh version we get from Homebrew
  # Uses the osx_chsh type out of boxen/puppet-osx
  osx_chsh { $::luser:
    shell   => '/opt/boxen/homebrew/bin/zsh',
    require => Package['zsh'],
  }

  file_line { 'add zsh to /etc/shells':
    path    => '/etc/shells',
    line    => "${boxen::config::homebrewdir}/bin/zsh",
    require => Package['zsh'],
  }
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




  android::build_tools { '22':
  }

  android::version{ '22':
    options => ['add_on', 'system_image', 'sample']
    }


}
