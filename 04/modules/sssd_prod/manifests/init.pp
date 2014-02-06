class sssd_prod {
  ini_setting {'krb5_realm_prod':
    path    => '/etc/sssd/sssd.conf',
    section => 'domain/PROD',
    setting => 'krb5_realm',
    value   => 'PROD',
  }
  ini_setting {'ldap_search_base_prod':
    path    => '/etc/sssd/sssd.conf',
    section => 'domain/PROD',
    setting => 'ldap_search_base',
    value   => 'ou=prod,dc=example,dc=com',
  }
  ini_setting {'ldap_uri_prod':
    path    => '/etc/sssd/sssd.conf',
    section => 'domain/PROD',
    setting => 'ldap_uri',
    value   => 'ldaps://ldap.prod.example.com',
  } 
  ini_setting {'krb5_kpasswd_prod':
    path    => '/etc/sssd/sssd.conf',
    section => 'domain/PROD',
    setting => 'krb5_kpasswd',
    value   => 'secret!', 
  }
  ini_setting {'krb5_server_prod':
    path    => '/etc/sssd/sssd.conf',
    section => 'domain/PROD',
    setting => 'krb5_server',
    value   => 'kdc.prod.example.com',
  }
  ini_subsetting {'domains_prod':
    path    => '/etc/sssd/sssd.conf',
    section => 'sssd',
    setting => 'domains',
    subsetting => 'PROD',
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

