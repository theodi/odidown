require "test_helper"

class DataTest < Test::Unit::TestCase

  @@html = %{<a href="http://google.com" data-variable="testing">Testing</a>}

  test "pass through data attributes" do
    assert_equal @@html, Govspeak::HtmlSanitizer.new(@@html).sanitize
  end

end
