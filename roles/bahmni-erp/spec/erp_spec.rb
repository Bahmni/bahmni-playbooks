require 'spec_helper'
require 'ansible_spec'
require 'specinfra'
require 'yaml'


describe package('python-gdata'), :if => os[:family] == 'redhat' do
  it { should be_installed }
end

describe command('rpm -qa | grep pgdg-centos') do
  its(:exit_status) { should eq 0 }
end

describe command('sudo pip show nonblockingloghandler') do
  its(:exit_status) { should eq 0 }
end

describe package('python-psycopg2'), :if => os[:family] == 'redhat' do
  it { should be_installed }
end

describe package('bahmni-erp'), :if => os[:family] == 'redhat' do
  it { should be_installed }
end

describe file('/etc/openerp/openerp-server.conf'), :if => os[:family] == 'redhat' do
  it { should exist }
end

describe iptables, :if => os[:family] == 'redhat' do
  it { should have_rule('-P INPUT ACCEPT').with_table('mangle').with_chain('INPUT') }
end

describe service('openerp'), :if => os[:family] == 'redhat' && $passive == 'false' do
  it { should be_running }
end

describe port(8069), :if => os[:family] == 'redhat' && $passive == 'false' do
  it { should be_listening }
end










