require "mysql2"
require 'ansible_spec'

inventory = AnsibleSpec.load_targets(AnsibleSpec.load_ansiblespec[1])

describe "mysql replication" do
  it "should work" do
    masterDbHost = inventory["bahmni-emr-db"][0]["uri"]
      slaveDbHost = inventory["bahmni-emr-db-slave"][0]["uri"]

    masterDbConnection = Mysql2::Client.new(:host => masterDbHost, :username => "root", :password => "password", :database => "openmrs")
    slaveDbConnection = Mysql2::Client.new(:host => slaveDbHost, :username => "root", :password => "password", :database => "openmrs")
    masterDbConnection.query("create table dummy_table (id int)")
    results = slaveDbConnection.query("select * from information_schema.tables where table_name = 'dummy_table';")
    expect(results).not_to be_nil
    masterDbConnection.query("drop table dummy_table")
  end
end