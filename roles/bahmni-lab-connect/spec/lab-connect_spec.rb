require 'spec_helper'
require 'ansible_spec'
require 'specinfra'
require 'yaml'


describe package('bahmni-lab-connect'), :if => os[:family] == 'redhat' do
  it { should be_installed }
end

describe service('openmrs'), :if => os[:family] == 'redhat' && $passive == 'false' do
  it { should be_running }
end









