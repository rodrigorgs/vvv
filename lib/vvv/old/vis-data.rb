#!/usr/bin/env ruby

require 'rinruby'
require 'graphviz'

class DataFrameFile
  attr_accessor :filename, :columns
  def initialize(_filename, _columns)
    @filename = File.basename(_filename)
    @columns = _columns
  end

  def filename=(f)
    @filename = File.basename(f)
  end

  def inspect
    "<#{@filename}: #{@columns.inspect}>"
  end
end

def collect_files
  files = []
  r = RinRuby.new(echo: false)
  Dir.glob('data/*.rds') do |filename|
    r.eval "x <- readRDS(\"#{filename}\")"
    cols = r.pull "colnames(x)"
    file = DataFrameFile.new(filename, cols)
    files << file
  end

  files
end

def export_graphviz(df_files)
  g = GraphViz.new(:G, type: :digraph)

  i = 0
  df_files.each do |df|
    label = "{#{df.filename}|#{df.columns.join('\l')}\\l}"
    p label
    g.add_nodes("n#{i}", label: label, shape: "record")
    i += 1
  end

  g.output(png: "doc/data.png")
end

if __FILE__ == $0
  x = collect_files
  export_graphviz(x)
end

