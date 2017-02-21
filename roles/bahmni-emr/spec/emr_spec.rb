require 'spec_helper'
require 'ansible_spec'
require 'specinfra'
require 'yaml'

describe file('/etc/yum.repos.d/mysql.repo'), :if => os[:family] == 'redhat' do
  it { should exist }
end

describe package('bahmni-openmrs'), :if => os[:family] == 'redhat' do
  it { should be_installed }
end

describe package('bahmni-emr'), :if => os[:family] == 'redhat' do
  it { should be_installed }
end

describe file('/opt/openmrs/etc/openmrs.conf'), :if => os[:family] == 'redhat' do
  it { should exist }
end

describe iptables, :if => os[:family] == 'redhat' do
  it { should have_rule('-P INPUT ACCEPT').with_table('mangle').with_chain('INPUT') }
end

describe file('/etc/bahmni-installer/deployment-artifacts/modules/'), :if => os[:family] == 'redhat' do
  it { should be_directory }
end

describe file('/var/www/cgi-bin/getversion.py'), :if => os[:family] == 'redhat' do
  it { should exist }
end

describe service('openmrs'), :if => os[:family] == 'redhat' && $passive == 'false' do
  it { should be_running }
end

describe port(8050), :if => os[:family] == 'redhat' && $passive == 'false' do
  it { should be_listening }
end