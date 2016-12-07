require 'spec_helper'
require 'ansible_spec'
require 'specinfra'

describe package('libselinux-python'), :if => os[:family] == 'redhat' do
  it { should be_installed }
end

describe file('/etc/yum.repos.d/bahmni.repo'), :if => os[:family] == 'redhat' do
  it { should exist }
end

describe package('epel-release'), :if => os[:family] == 'redhat' do
  it { should be_installed }
end

describe package('ntp'), :if => os[:family] == 'redhat' do
  it { should be_installed }
end

#describe file('/etc/bahmni-installer/setup.yml') do
#  its(:content_as_yaml) { should include('timezone') }
#end

describe service('ntpd') do
  it { should be_enabled }
end

describe service('ntpd') do
  it { should be_running }
end

describe package('tree'), :if => os[:family] == 'redhat' do
  it { should be_installed }
end

describe package('htop'), :if => os[:family] == 'redhat' do
  it { should be_installed }
end

describe package('lsof'), :if => os[:family] == 'redhat' do
  it { should be_installed }
end

describe package('wget'), :if => os[:family] == 'redhat' do
  it { should be_installed }
end

describe package('unzip'), :if => os[:family] == 'redhat' do
  it { should be_installed }
end

describe package('python-pip'), :if => os[:family] == 'redhat' do
  it { should be_installed }
end

describe package('rsync'), :if => os[:family] == 'redhat' do
  it { should be_installed }
end

describe package('policycoreutils'), :if => os[:family] == 'redhat' do
  it { should be_installed }
end