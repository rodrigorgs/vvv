def vvv_config
  config = {
    R: {
      INPUT_REGEX: /^\s*vvv_input\s*<-\s*['"](.+?)['"]/,
      INPUT_FORMAT: 'vvv_input <- "%s"',
      OUTPUT_REGEX: /^\s*vvv_output\s*<-\s*['"](.+?)['"]/,
      OUTPUT_FORMAT: 'vvv_output <- "%s"',
      VVV_REGEX: /vvv_eval\(["'](.*?)["'](?:,.*?)?\)/
    },
    rb: {
      INPUT_REGEX: /^\s*vvv_input\s*=\s*['"](.+?)['"]/,
      INPUT_FORMAT: 'vvv_input = "%s"',
      OUTPUT_REGEX: /^\s*vvv_output\s*=\s*['"](.+?)['"]/,
      OUTPUT_FORMAT: 'vvv_output = "%s"',
      VVV_REGEX: /vvv_eval\(["'](.*?)["'](?:,.*?)?\)/
    }
  }

  config
end

# def vvv_folders
#   folders = {
#     generated_scripts: 'script',
#     script_templates: 'template',
#     visualizations: 'doc'
#   }

#   folders
# end