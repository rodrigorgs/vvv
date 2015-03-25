require 'rake/testtask'

Rake::TestTask.new do |t|
  t.libs << 'test'
end

desc "Run tests"
task :default => :test

task :build do
  system "gem build vvv.gemspec"
end

task :install => :build do
  system "gem install ./vvv-0.0.1.gem"
end
