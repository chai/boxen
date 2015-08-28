require boxen::environment
require homebrew
require gcc


Exec {
  group       => 'staff',
  logoutput   => on_failure,
  user        => $boxen_user,

  path => [
    "${boxen::config::home}/rbenv/shims",
    "${boxen::config::home}/rbenv/bin",
    "${boxen::config::home}/rbenv/plugins/ruby-build/bin",
    "${boxen::config::homebrewdir}/bin",
    '/usr/bin',
    '/bin',
    '/usr/sbin',
    '/sbin'
  ],

  environment => [
    "HOMEBREW_CACHE=${homebrew::config::cachedir}",
    "HOME=/Users/${::boxen_user}"
  ]
}

File {
  group => 'staff',
  owner => $boxen_user
}

Package {
  provider => homebrew,
  require  => Class['homebrew']
}

Repository {
  provider => git,
  extra    => [
    '--recurse-submodules'
  ],
  require  => File["${boxen::config::bindir}/boxen-git-credential"],
  config   => {
    'credential.helper' => "${boxen::config::bindir}/boxen-git-credential"
  }
}

Service {
  provider => ghlaunchd
}

Homebrew::Formula <| |> -> Package <| |>

package { 'skype': provider => 'brewcask' }
package { 'evernote': provider => 'brewcask' }


node default {
  # core modules, needed for most things
  include dnsmasq
  include git
  include hub
  include nginx

  include dropbox
  include java
  include android::sdk
  include android::ndk
  include android::tools
  include android::platform_tools
  include android::studio

  include osx::global::expand_print_dialog  #- expand the print dialog by default
  include osx::global::expand_save_dialog   #- expand the save dialog by default
  include osx::global::tap_to_click         #- enables tap to click
  include osx::finder::unhide_library       #- unsets the hidden flag on ~/Library
  include osx::finder::show_hidden_files
  include osx::no_network_dsstores          #- disable creation of .DS_Store files on network shares
  include osx::software_update              #- download and install software updates
  include osx::dock::icon_size              #-set the size to 36

  include virtualbox
  include crashplan
#include quicksilver
#include atom
#include firefox
#include better_touch_tools
#include notational_velocity::nvalt
#include vlc
#include transmission
#include openssl
#include sublime_text_2
include zsh
include skydrive
include textmate::textmate2::release

include mysql
#include postgresql

}


#class{ 'vlc':
#version=>'2.2.1'
#}

#sublime_text_2::package {'Emmet':
#source => 'sergeche/emmet-sublime'
#}

mysql::db { 'mysqldb': }
#postgresql::db {'postgresqldb'}
