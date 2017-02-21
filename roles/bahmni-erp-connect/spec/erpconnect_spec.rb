require 'spec_helper'
require 'ansible_spec'
require 'specinfra'
require 'yaml'


describe package('bahmni-erp-connect'), :if => os[:family] == 'redhat' do
  it { should be_installed }
end

describe file('/opt/bahmni-erp-connect/etc/bahmni-erp-connect.conf'), :if => os[:family] == 'redhat' do
  it { should exist }
end

describe file('/opt/bahmni-erp-connect/bahmni-erp-connect/WEB-INF/classes/atomfeed.properties'), :if => os[:family] == 'redhat' do
  it { should exist }
end

describe service('bahmni-erp-connect'), :if => os[:family] == 'redhat' && $passive == 'false' do
  it { should be_running }
end







