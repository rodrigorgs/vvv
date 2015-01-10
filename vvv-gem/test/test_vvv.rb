require 'test/unit'
require_relative '../lib/vvv/base'

class VvvTest < Test::Unit::TestCase
  def setup
    @varconf = {'test.R' => [{'var' => 'alpha'}, {'var' => 'beta'}]}
    @confs = @varconf['test.R']
    @v = VariableScript.new('test.R')
  end

  def test_contents_for_configuration
    contents = '# INPUT: x-%{var}.rds'
    expected = '# INPUT: x-alpha.rds'
    @v.instance_variable_set(:@contents, contents)
    assert_equal expected, @v.contents_for_configuration(@confs[0])

    contents = '# OUTPUT: x-%{var}.rds'
    expected = '# OUTPUT: x-alpha.rds'
    @v.instance_variable_set(:@contents, contents)
    assert_equal expected, @v.contents_for_configuration(@confs[0])
  end

  def test_contents_for_multiple_configurations
    contents = '# INPUT: x-%{var}.rds'
    expected = ['# INPUT: x-alpha.rds', '# INPUT: x-beta.rds'].join("\n")
    @v.instance_variable_set(:@contents, contents)
    assert_equal expected, @v.contents_for_multiple_configurations(@confs)

    contents = '# OUTPUT: x-%{var}.rds'
    expected = ['# OUTPUT: x-alpha.rds', '# OUTPUT: x-beta.rds'].join("\n")
    @v.instance_variable_set(:@contents, contents)
    assert_equal expected, @v.contents_for_multiple_configurations(@confs)
  end
end

