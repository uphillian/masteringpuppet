Name:           example.com-puppet
Version:	1.0
Release:	2%{?dist}
Summary:	Puppet Apply for example.com

Group:		System/Utilities
License:	GNU
Source0:	example.com-puppet-%{version}.tar.bz2
BuildRoot:	%(mktemp -ud %{_tmppath}/%{name}-%{version}-%{release}-XXXXXX)

Requires:	puppet
BuildArch:      noarch

%description
This package installs example.com's puppet configuration
and applies that configuration on the machine.


%prep
%setup -q -c


%build
# nothind to build


%install
mkdir -p $RPM_BUILD_ROOT/%{_localstatedir}/local/puppet
cp -a . $RPM_BUILD_ROOT/%{_localstatedir}/local/puppet

%clean
rm -rf %{buildroot}


%files
%defattr(-,root,root,-)
%{_localstatedir}/local/puppet

%post
# run puppet apply
/bin/env puppet apply --logdest syslog --modulepath=%{_localstatedir}/local/puppet/modules %{_localstatedir}/local/puppet/manifests/site.pp 
# install cron job
/bin/env puppet resource cron 'example.com-puppet' command='/bin/env puppet apply --logdest syslog --modulepath=%{_localstatedir}/local/puppet/modules %{_localstatedir}/local/puppet/manifests/site.pp' minute='*/30' ensure='present'

%changelog
* Sun Dec 8 2013 Thomas Uphill <thomas@narrabilis.com> - 1.0-2
- added cron job creation

* Fri Dec 6 2013 Thomas Uphill <thomas@narrabilis.com> - 1.0-1
- initial build 
