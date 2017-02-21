require 'spec_helper'
require 'ansible_spec'
require 'specinfra'
require 'yaml'


describe file('/etc/yum.repos.d/mysql.repo'), :if => os[:family] == 'redhat' do
  it { should exist }
end

describe package('MySQL-python'), :if => os[:family] == 'redhat' do
  it { should be_installed }
end

describe package('mysql-community-common'), :if => os[:family] == 'redhat' do
  it { should be_installed }
end

describe package('mysql-community-libs'), :if => os[:family] == 'redhat' do
  it { should be_installed }
end

describe package('mysql-community-client'), :if => os[:family] == 'redhat' do
  it { should be_installed }
end

describe package('mysql-community-server'), :if => os[:family] == 'redhat' do
  it { should be_installed }
end

describe file('/var/log/mysql'), :if => os[:family] == 'redhat' do
  it { should exist }
end

describe file('/etc/my.cnf'), :if => os[:family] == 'redhat' do
  it { should exist }
end

describe service('mysqld'), :if => os[:family] == 'redhat' do
  it { should be_running }
end

describe iptables, :if => os[:family] == 'redhat' do
  it { should have_rule('-P INPUT ACCEPT').with_table('mangle').with_chain('INPUT') }
end

describe port(3306), :if => os[:family] == 'redhat' do
  it { should be_listening }
end












