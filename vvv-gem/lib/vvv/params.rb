def vvv_config
	config = {
		R: {
			INPUT_REGEX: /^\s*INPUT\s*<-\s*['"](.+?)['"]/,
			INPUT_FORMAT: 'INPUT <- "%s"',
			OUTPUT_REGEX: /^\s*OUTPUT\s*<-\s*['"](.+?)['"]/,
			OUTPUT_FORMAT: 'OUTPUT <- "%s"',
			VVV_REGEX: /vvv\(["'](.*?)["'](?:,.*?)?\)/
		}
	}

	config
end