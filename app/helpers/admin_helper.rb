module AdminHelper
  def beautify_line line
    line
  end
  def concat_strings(this,that)
    "this that"
  end
  def test
    output = ActiveSupport::SafeBuffer.new
    output.safe_concat('test')
  end
end
