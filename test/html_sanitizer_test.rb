require "test_helper"

class HtmlSanitizerTest < Test::Unit::TestCase

  test "allow youtube embeds" do
    html = '<iframe width="560" height="315" src="//www.youtube.com/embed/OZPTM0PGQPE" frameborder="0" allowfullscreen></iframe>'
    assert_equal html, Govspeak::HtmlSanitizer.new(html).sanitize
  end

end
