require 'rubygems'
require 'spec/rake/spectask'

begin
  require 'jeweler'
  Jeweler::Tasks.new do |gemspec|
    gemspec.name = "mostash"
    gemspec.summary = "A combo of OpenStruct and a ruby hash"
    gemspec.description = "You can treat an object as either a hash or as an OpenStruct. In additon to this you can create them nested, unlike OpenStruct"
    gemspec.email = "asher.friedman@gmail.com"
    #gemspec.homepage = "http://github.com/technicalpickles/the-perfect-gem"
    gemspec.authors = ["Joel Friedman"]

    gemspec.add_development_dependency "rspec"
  end
rescue LoadError
  puts "Jeweler not available. Install it with: gem install jeweler"
end

desc "run all specs"
Spec::Rake::SpecTask.new( "spec" ) do |t|
  t.spec_files = FileList["spec/**/*_spec.rb"]
end
