require "test_helper"

class HtmlSanitizerTest < Test::Unit::TestCase

  test "allow youtube embeds" do
    html = '<iframe width="560" height="315" src="//www.youtube.com/embed/OZPTM0PGQPE" frameborder="0" allowfullscreen></iframe>'
    assert_equal html, Govspeak::HtmlSanitizer.new(html).sanitize
  end
  
  test "allow soundcloud embeds" do
    html = '<iframe width="100%" height="166" frameborder="no" src="https://w.soundcloud.com/player/?url=http%3A%2F%2Fapi.soundcloud.com%2Ftracks%2F81761778"></iframe>'
    assert_equal html, Govspeak::HtmlSanitizer.new(html).sanitize
  end

end
