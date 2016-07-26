require 'rake'
require 'rspec/core/rake_task'
require 'yaml'
require 'ansible_spec'
require 'termios'


properties = AnsibleSpec.get_properties
desc "Run serverspec to all test"
task :all => "serverspec:all"

namespace :serverspec do
  task :all => properties.map {|v| 'serverspec:' + v["name"].to_s }
  properties = properties.compact.reject{|e| e["hosts"].length == 0}
  properties.each_with_index.map do |property, index|
    property["hosts"].each do |host|
      desc "Run serverspec for #{property["name"]}"
      RSpec::Core::RakeTask.new(property["name"].to_s.to_sym) do |t|
        puts "Run serverspec for #{property["name"]} to #{host}"
        ENV['TARGET_HOSTS'] = host["hosts"]
        ENV['TARGET_HOST'] = host["uri"]
        ENV['TARGET_PORT'] = host["port"].to_s
        ENV['TARGET_GROUP_INDEX'] = index.to_s
        ENV['TARGET_PRIVATE_KEY'] = host["private_key"]
        unless host["user"].nil?
          ENV['TARGET_USER'] = host["user"]
        else
          ENV['TARGET_USER'] = property["user"]
        end
        ENV['TARGET_PASSWORD'] = host["pass"]
        ENV['TARGET_CONNECTION'] = host["connection"]

        roles = property["roles"]
        for role in property["roles"]
          p role
          deps = AnsibleSpec.load_dependencies(role)
          roles += deps
        end
        t.pattern = 'roles/{' + roles.join(',') + '}/spec/*_spec.rb'
      end
    end
  end
end
