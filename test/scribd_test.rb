require "test_helper"

class ScribdTest < Test::Unit::TestCase

  @@html = %{<iframe class="scribd_iframe_embed" src="http://www.scribd.com/embeds/152704524/content?start_page=1&amp;view_mode=scroll&amp;access_key=key-8tvxstotq2hb7yc3672&amp;show_recommendations=true" data-auto-height="false" data-aspect-ratio="1.33234859675037" scrolling="no" id="doc_33290" width="100%" height="600" frameborder="0"></iframe>}

  test "allow scribd embeds" do
    assert_equal @@html, Govspeak::HtmlSanitizer.new(@@html).sanitize
  end

  test "scribd extension with ID" do
    odidown = 'scribd[152704524]'
    assert Govspeak::Document.new(odidown).to_html.include? @@html
  end

  test "scribd extension with URL" do
    odidown = 'scribd[http://www.scribd.com/doc/152704524/Data-as-the-Divine]'
    assert Govspeak::Document.new(odidown).to_html.include? @@html
  end

  test "generic embed with scribd URL" do
    odidown = 'embed[http://www.scribd.com/doc/152704524/Data-as-the-Divine]'
    assert Govspeak::Document.new(odidown).to_html.include? @@html
  end

  test "scribd embed with specified size" do
    odidown = 'embed[http://www.scribd.com/doc/152704524/Data-as-the-Divine|200,100]'
    assert Govspeak::Document.new(odidown).to_html.include? 'width="200" height="100"'
  end

end
