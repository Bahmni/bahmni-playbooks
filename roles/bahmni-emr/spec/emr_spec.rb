require 'spec_helper'
require 'ansible_spec'
require 'specinfra'

describe service('httpd'), :if => os[:family] == 'redhat' do
  it { should be_enabled }
  it { should be_running }
end

describe port(80) do
  it { should be_listening }
end