require "test_helper"

class ClassTest < Test::Unit::TestCase

  @@html = %{<a href="http://google.com" class="testing">Testing</a>}

  test "pass through classes" do
    assert_equal @@html, Govspeak::HtmlSanitizer.new(@@html).sanitize
  end

end
