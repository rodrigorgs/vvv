#!/usr/bin/env ruby

require 'fileutils'

def create_notebook(path)
  dir = File.dirname(path)
  filename = File.basename(path)
  filename_no_ext = File.basename(filename, ".*")

  oldpwd = FileUtils.pwd
  FileUtils.chdir(dir)

  system %Q[Rscript -e "library(knitr); library(markdown); knitr::spin('#{filename}'); markdownToHTML('#{filename_no_ext}.md', '#{filename_no_ext}.html')"]

  FileUtils.rm "#{filename_no_ext}.md" if File.exist?("#{filename_no_ext}.md")
  FileUtils.mv "#{filename_no_ext}.html", '../report' if File.exist?("#{filename_no_ext}.html") && File.directory?("../report")

  # # Fix rCharts bug
  # sed -i ".bak" -e 's/\\\\n/\\n/g' figure/*.html
  # rm figure/*.bak

  FileUtils.chdir(oldpwd)
end

if __FILE__ == $0

  if ARGV.size == 0
    puts
    puts "Creates a report from a R script at ../report, using knitr::spin."
    puts "Usage: #{File.basename(__FILE__)} R-file"
    puts
    exit 1
  end

  path = ARGV[0]
  create_notebook(path)

end