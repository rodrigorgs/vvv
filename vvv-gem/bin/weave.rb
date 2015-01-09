#!/usr/bin/env ruby

begin
  require 'vvv'
rescue LoadError
  require 'rubygems'
  require 'mygem'
end
require 'json'
require 'fileutils'


# Weave template files
json = JSON.parse(IO.read('Varconf.json'))
json.each_pair do |script, confs|
  file = VariableScript.new(script)

  if file.original_name == 'join.R'
    output_path = "script/#{file.original_name}"
    contents = file.contents_for_multiple_configurations(confs)
    File.open(output_path, "w") { |f| f.write contents }
  else
    confs.each do |conf|
      output_path = "script/#{file.name_for_configuration(conf)}"
      contents = file.contents_for_configuration(conf)
      contents = "# Configuration: #{conf.inspect}\n" + contents
      File.open(output_path, "w") { |f| f.write contents }
    end
  end
end

# Copy non-template files
all_files = Dir.entries("template").grep(/^[^.]/)
templates = json.keys
(all_files - templates).each do |file|
  FileUtils.cp "template/#{file}", "script/#{file}"
end
