#!/usr/bin/env ruby

require 'ruby-graphviz'
require 'pathname'
require 'fileutils'

class ProcessingNode
  attr_reader :filename
  attr_reader :script_path
  attr_reader :inputs, :outputs
  attr_reader :input_paths, :output_paths

  def initialize(_script_path)
    @filename = File.basename(_script_path)
    @script_path = _script_path
    @inputs = []
    @outputs = []
    @input_paths = []
    @output_paths = []
  end

  def script_dir
    File.dirname(@script_path)
  end

  # path is relative to script
  def path_relative_to_current(path)
    abs_path = Pathname.new(File.absolute_path(path, script_dir))
    abs_path.relative_path_from(Pathname.pwd).to_path
  end

  def add_input(path)
    @inputs << File.basename(path)
    @input_paths << path_relative_to_current(path)
  end

  def add_output(path)
    @outputs << File.basename(path)
    @output_paths << path_relative_to_current(path)
  end
end

def collect_flow
  nodes = []

  Dir.glob("script/*.R") do |filename|
    lines = IO.readlines(filename)
    contents = IO.read(filename)

    node = ProcessingNode.new(filename)
    contents.scan(/# INPUT: (.+)/) { |m| node.add_input(m[0]) }
    contents.scan(/# OUTPUT: (.+)/) { |m| node.add_output(m[0]) }
    nodes << node
  end

  Dir.glob("script/*.rb") do |filename|
    next if filename =~ /run-script.rb$/

    lines = IO.readlines(filename)
    contents = IO.read(filename)
    
    node = ProcessingNode.new(filename)
    contents.scan(/IO.readlines\(['"](.*?)['"]\) | File.open\(['"](.*?)['"],\s*['"]r['"]\)/x) do |m|
      node.add_input(m[0])
    end
    contents.scan(/File.open\(['"](.*?)['"],\s*['"]w['"]\)/x) do |m|
      node.add_output(m[0])
    end
    nodes << node
  end

  nodes
end

class GraphvizExporter
  def initialize(nodes)
    @data_to_node = Hash.new
    @nodes = nodes.select { |n| !n.inputs.empty? || !n.outputs.empty? }
    @graph = GraphViz.new(:G, type: :digraph)
  end

  def node_for_filename(filename)
    node = @data_to_node[filename]
    if node.nil?
      # data file
      node = @graph.add_nodes(filename, penwidth: 0.1, color: '#666666')
      @data_to_node[filename] = node
    end
    node
  end

  def export_graphviz
    @nodes.each do |node|
      # script file
      html_filename = File.basename(node.filename, ".*") + ".html"
      script_node = @graph.add_nodes(node.filename, 
          shape: 'rectangle',
          fillcolor: '#eeeeee',
          style: 'filled',
          URL: "../report/#{html_filename}")
      node.inputs.each do |input|
        @graph.add_edges(node_for_filename(input), script_node)
      end
      node.outputs.each do |output|
        @graph.add_edges(script_node, node_for_filename(output))
      end
    end

    @graph.output(dot: "doc/flow.dot")
    @graph.output(pdf: "doc/flow.pdf")
   
    # create html imagemap
    system "dot -Tcmapx -o doc/flow.html -Tpng -o doc/flow.png doc/flow.dot"
    new_html = '<img src="flow.png" usemap="#G" />' + IO.read('doc/flow.html')
    File.open('doc/flow.html', 'w') { |f| f.print(new_html) }
    FileUtils.rm 'doc/flow.dot' 
  end
end

def run_vis_flow
  nodes = collect_flow
  GraphvizExporter.new(nodes).export_graphviz
end

if __FILE__ == $0
  run_vis_flow
end
