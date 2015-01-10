require 'pathname'

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
    contents.scan(vvv_config[:R][:INPUT_REGEX]) { |m| node.add_input(m[0]) }
    contents.scan(vvv_config[:R][:OUTPUT_REGEX]) { |m| node.add_output(m[0]) }
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