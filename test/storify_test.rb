require "test_helper"

class StorifyTest < Test::Unit::TestCase

  @@html = %{<script src="//storify.com/pikesley/the-saga-of-the-penguin-head.js"></script>}

  test "allow storify embeds" do
    assert_equal @@html, Govspeak::HtmlSanitizer.new(@@html).sanitize
  end

  test "storify extension" do
    odidown = 'storify[http://storify.com/pikesley/the-saga-of-the-penguin-head]'
    assert Govspeak::Document.new(odidown).to_html.include? @@html
  end

  test "storify with generic embed" do
    odidown = 'embed[http://storify.com/pikesley/the-saga-of-the-penguin-head]'
    assert Govspeak::Document.new(odidown).to_html.include? @@html
  end

end
