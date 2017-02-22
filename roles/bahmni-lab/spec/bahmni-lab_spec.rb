require 'spec_helper'
require 'ansible_spec'
require 'specinfra'
require 'yaml'


describe package('bahmni-lab'), :if => os[:family] == 'redhat' do
  it { should be_installed }
end

describe file('/etc/bahmni-lab/bahmni-lab.conf'), :if => os[:family] == 'redhat' do
  it { should exist }
end

describe file('/opt/bahmni-lab/bahmni-lab/WEB-INF/classes/us/mn/state/health/lims/hibernate/hibernate.cfg.xml'), :if => os[:family] == 'redhat' do
  it { should exist }
end

describe iptables, :if => os[:family] == 'redhat' do
  it { should have_rule('-P INPUT ACCEPT').with_table('mangle').with_chain('INPUT') }
end

describe file('/opt/bahmni-lab/add_remote_ip_in_openelis_markers.sh'), :if => os[:family] == 'redhat' && $passive == 'false' do
  it { should exist }
end

describe service('bahmni-lab'), :if => os[:family] == 'redhat' && $passive == 'false' do
  it { should be_running }
end











