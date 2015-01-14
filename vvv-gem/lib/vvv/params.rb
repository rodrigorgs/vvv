def vvv_config
	config = {
		R: {
			INPUT_REGEX: /^\s*INPUT\s*<-\s*['"](.+?)['"]/,
			INPUT_FORMAT: 'INPUT <- "%s"',
			OUTPUT_REGEX: /^\s*OUTPUT\s*<-\s*['"](.+?)['"]/,
			OUTPUT_FORMAT: 'OUTPUT <- "%s"',
			VVV_REGEX: /vvv\(["'](.*?)["'](?:,.*?)?\)/
		},
		rb: {
			INPUT_REGEX: /^\s*vvv_INPUT\s*=\s*['"](.+?)['"]/,
			INPUT_FORMAT: 'vvv_INPUT = "%s"',
			OUTPUT_REGEX: /^\s*vvv_OUTPUT\s*=\s*['"](.+?)['"]/,
			OUTPUT_FORMAT: 'vvv_OUTPUT = "%s"',
			VVV_REGEX: /vvv\(["'](.*?)["'](?:,.*?)?\)/
		}
	}

	config
end