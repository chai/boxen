
include osx::global::expand_print_dialog  #- expand the print dialog by default
include osx::global::expand_save_dialog   #- expand the save dialog by default
include osx::global::tap_to_click         #- enables tap to click
include osx::finder::unhide_library       #- unsets the hidden flag on ~/Library
include osx::finder::show_hidden_files
include osx::no_network_dsstores          #- disable creation of .DS_Store files on network shares
include osx::software_update              #- download and install software updates

include osx::dock::icon_size              #-set the size to 36


class people::chai::osx{



osx::recovery_message { 'If this Mac is found, please call 090-3140-0282': }




}
