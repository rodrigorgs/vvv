require 'ruby-graphviz'
require 'fileutils'

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
      color = File.exist?(filename) ? '#666666' : '#660000'
      node = @graph.add_nodes(filename, penwidth: 0.1, color: color)
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
