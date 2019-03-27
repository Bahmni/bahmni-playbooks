require 'pg'
require 'ansible_spec'

inventory = AnsibleSpec.load_targets(AnsibleSpec.load_ansiblespec[1])

describe "replication" do
  it "should work in bahmni lab database" do
    masterDbHost = inventory["bahmni-lab-db"][0]["uri"]
    slaveDbHost = inventory["bahmni-lab-db-slave"][0]["uri"]

    print masterDbHost
    print slaveDbHost

    masterDbConnection = PG.connect :host=> masterDbHost, :user => 'postgres', :password=> '', :dbname => 'clinlims'
    slaveDbConnection = PG.connect :host=> slaveDbHost, :user => 'clinlims', :password=> '', :dbname => 'clinlims'
    masterDbConnection.query("create table dummy_table (id int)")
    results = slaveDbConnection.query("select * from information_schema.tables where table_name = 'dummy_table';")
    expect(results).not_to be_nil
    masterDbConnection.query("drop table dummy_table")
    end

  it "should work in openerp database" do
    masterDbHost = inventory["bahmni-erp-db"][0]["uri"]
    slaveDbHost = inventory["bahmni-erp-db-slave"][0]["uri"]

    print masterDbHost
    print slaveDbHost

    masterDbConnection = PG.connect :host=> masterDbHost, :user => 'postgres', :password=> '', :dbname => 'odoo'
    slaveDbConnection = PG.connect :host=> slaveDbHost, :user => 'odoo', :password=> '', :dbname => 'odoo'
    masterDbConnection.query("create table dummy_table (id int)")
    results = slaveDbConnection.query("select * from information_schema.tables where table_name = 'dummy_table';")
    expect(results).not_to be_nil
    masterDbConnection.query("drop table dummy_table")
  end
end