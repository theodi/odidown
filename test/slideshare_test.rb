require "test_helper"

class SlideshareTest < Test::Unit::TestCase

  @@html = %{<iframe src="http://www.slideshare.net/slideshow/embed_code/22805706?rel=0" width="427" height="356" frameborder="0" marginwidth="0" marginheight="0" scrolling="no" style="border:1px solid #CCC;border-width:1px 1px 0;margin-bottom:5px" allowfullscreen="" webkitallowfullscreen="" mozallowfullscreen=""> </iframe>}

  test "allow slideshare embeds" do
    assert_equal @@html, Govspeak::HtmlSanitizer.new(@@html).sanitize
  end

  test "slideshare extension with ID" do
    odidown = 'slideshare[22805706]'
    assert Govspeak::Document.new(odidown).to_html.include? @@html
  end

  test "slideshare extension with URL" do
    odidown = 'slideshare[http://www.slideshare.net/EmilandDC/dear-nsa-let-me-take-care-ou]'
    assert Govspeak::Document.new(odidown).to_html.include? @@html
  end

  test "generic embed with slideshare URL" do
    odidown = 'embed[http://www.slideshare.net/EmilandDC/dear-nsa-let-me-take-care-ou]'
    assert Govspeak::Document.new(odidown).to_html.include? @@html
  end

  test "slideshare embed with specified size" do
    odidown = 'embed[http://www.slideshare.net/EmilandDC/dear-nsa-let-me-take-care-ou|200,100]'
    assert Govspeak::Document.new(odidown).to_html.include? 'width="200" height="100"'
  end

end
