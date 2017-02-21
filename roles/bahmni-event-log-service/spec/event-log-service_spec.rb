require 'spec_helper'
require 'ansible_spec'
require 'specinfra'
require 'yaml'


describe package('bahmni-event-log-service'), :if => os[:family] == 'redhat' do
  it { should be_installed }
end

describe file('/opt/bahmni-event-log-service/etc/bahmni-event-log-service.conf'), :if => os[:family] == 'redhat' do
  it { should exist }
end

describe file('/opt/bahmni-event-log-service/bahmni-event-log-service/WEB-INF/classes/application.properties'), :if => os[:family] == 'redhat' do
  it { should exist }
end

describe iptables, :if => os[:family] == 'redhat' do
  it { should have_rule('-P INPUT ACCEPT').with_table('mangle').with_chain('INPUT') }
end

describe service('bahmni-event-log-service'), :if => os[:family] == 'redhat' && $passive == 'false' do
  it { should be_running }
end







