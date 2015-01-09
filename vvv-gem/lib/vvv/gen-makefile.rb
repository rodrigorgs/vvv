#!/usr/bin/env ruby

require_relative 'vis-flow'

@makefile = []
@outputs = []

def run_gen_makefile
	@flow = collect_flow

	@flow.each do |script|
		next if script.input_paths.empty? && script.output_paths.empty?

		if script.script_path.end_with?('.R')
			notebook = File.basename(script.script_path).gsub(/\.R$/, ".html")
			script.output_paths << "report/#{notebook}"
		end

		script.output_paths.each do |output|
			@makefile << "#{output}: #{script.input_paths.join(' ')} #{script.script_path}"
			@makefile << "\t./run-script.rb #{script.script_path}"
			@makefile << ""
			@outputs += script.output_paths
		end
	end	

	out = ''
	out += "all: #{@outputs.sort.uniq.join(' ')}\n\n"
	out += "clean:\n\trm -f #{@outputs.sort.uniq.join(' ')}\n\n"
	out += @makefile.join("\n")

	File.open('Makefile', 'w') { |f| f.puts(out) }
end

if __FILE__ == $0
  run_gen_makefile
end
