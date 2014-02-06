class sssd_devel {
  ini_setting {'krb5_realm_devel':
    path    => '/etc/sssd/sssd.conf',
    section => 'domain/DEVEL',
    setting => 'krb5_realm',
    value   => 'DEVEL',
  }
  ini_setting {'ldap_search_base_devel':
    path    => '/etc/sssd/sssd.conf',
    section => 'domain/DEVEL',
    setting => 'ldap_search_base',
    value   => 'ou=devel,dc=example,dc=com',
  }
  ini_setting {'ldap_uri_devel':
    path    => '/etc/sssd/sssd.conf',
    section => 'domain/DEVEL',
    setting => 'ldap_uri',
    value   => 'ldaps://ldap.devel.example.com',
  } 
  ini_setting {'krb5_kpasswd_devel':
    path    => '/etc/sssd/sssd.conf',
    section => 'domain/DEVEL',
    setting => 'krb5_kpasswd',
    value   => 'DevelopersDevelopersDevelopers', 
  }
  ini_setting {'krb5_server_devel':
    path    => '/etc/sssd/sssd.conf',
    section => 'domain/DEVEL',
    setting => 'krb5_server',
    value   => 'dev1.devel.example.com',
  }
  ini_subsetting {'domains_devel':
    path    => '/etc/sssd/sssd.conf',
    section => 'sssd',
    setting => 'domains',
    subsetting => 'DEVEL',
  }
}
#ldap_group_search_base = <%= ldap_group_search_base %>
#id_provider = ldap
#auth_provider = krb5
#chpass_provider = krb5
#ldap_uri = <%= ldap_uri %>
#krb5_kpasswd = <%= krb5_kpasswd %>
#krb5_server = <%= krb5_server %>
#cache_credentials = True
#ldap_tls_cacertdir = /etc/openldap/cacerts
#ldap_default_bind_dn = <%= ldap_default_bind_dn %>
#ldap_default_authtok_type = password
#ldap_default_authtok = <%= ldap_default_authtok %>
#ldap_user_object_class = person
#ldap_user_name = sAMAccountName

