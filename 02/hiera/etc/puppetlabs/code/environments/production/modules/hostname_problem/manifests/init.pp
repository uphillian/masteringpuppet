class hostname_problem ($enc_hostname) {
  notify {"WARNING: $enc_hostname ($::ipaddress) doesn't conform to naming standards": }
}

