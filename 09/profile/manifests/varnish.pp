# profile::varnish
# default is to listen on 80 and use 127.0.0.1:80 as backend
class profile::varnish {
  include ::varnish
}
