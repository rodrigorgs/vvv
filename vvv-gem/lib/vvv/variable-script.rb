class VariableScript
  attr_reader :original_name
  attr_reader :name_pattern
  attr_reader :contents

  def initialize(_original_name)
    @original_name = _original_name
  end

  def contents
    if @contents.nil?
      @contents = IO.read("template/#{original_name}")
    end
    @contents
  end

  # ex.: specifics-%{gender}.R
  def name_pattern
    if @name_pattern.nil?
      text = contents
      if text =~ /^# SCRIPT: (.+)/
        @name_pattern = $1
      else
        @name_pattern = original_name
      end
    end
    @name_pattern
  end

  def name_for_configuration(conf)
    conf_sym = convert_keys_to_sym(conf)
    name_pattern % conf_sym
  end

  def contents_for_configuration(conf)
    conf_sym = convert_keys_to_sym(conf)
    
    ret = contents
    ret = ret.gsub(vvv_config[:R][:VVV_REGEX]) { conf_sym[$1.to_sym].inspect }
    ret = ret.gsub(vvv_config[:R][:INPUT_REGEX]) { vvv_config[:R][:INPUT_FORMAT] % ($1 % conf_sym) }
    ret = ret.gsub(vvv_config[:R][:OUTPUT_REGEX]) { vvv_config[:R][:OUTPUT_FORMAT] % ($1 % conf_sym) }
    ret
  end

  def contents_for_multiple_configurations(confs)
    confs = confs.map { |conf| convert_keys_to_sym(conf) }
    ret = contents
    ret = ret.gsub(vvv_config[:R][:VVV_REGEX]) do
      x = confs.map { |conf| conf[$1.to_sym].inspect }.uniq
      x.size == 1 ? x[0].inspect : "c(#{x.join(', ')})"
    end

    v = vvv_config[:R]
    [[v[:INPUT_REGEX], v[:INPUT_FORMAT]], [v[:OUTPUT_REGEX], v[:OUTPUT_FORMAT]]].each do |regex, format|
      ret = ret.gsub(regex) do
        items = confs.map { |conf| format % ($1 % conf) }
        items.uniq.join("\n")
      end
    end

    ret
  end

  private
  def convert_keys_to_sym(conf)
    conf = conf.inject({}){|memo,(k,v)| memo[k.to_sym] = v; memo}
    conf[:script] = original_name
    conf
  end
end