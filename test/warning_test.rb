require 'minitest/autorun'

module Warning
  def self.warn(msg)
    warnings << msg
    super
  end

  def self.warnings
    @warnings ||= []
  end
end

class WarningTest < Minitest::Test
  def setup
    Warning.warnings.clear
  end

  # https://bugs.ruby-lang.org/issues/12299
  def test_warn
    assert Fixnum == Integer # Run to give warnings
    assert_equal 1, Warning.warnings.size
    msg = Warning.warnings.first
    assert msg.include?('warning: constant ::Fixnum is deprecated')
  end
end
