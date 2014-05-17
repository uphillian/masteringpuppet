$role = hiera('role','none')

node default {
  class {"$::role": }
  hiera_include('classes',base)
}
