require "test_helper"

class VimeoTest < Test::Unit::TestCase

  @@html = %{<iframe src="https://player.vimeo.com/video/11911548" width="500" height="375" frameborder="0" webkitallowfullscreen="" mozallowfullscreen="" allowfullscreen=""></iframe>}

  test "allow vimeo embeds" do
    assert_equal @@html, Govspeak::HtmlSanitizer.new(@@html).sanitize
  end

  test "vimeo extension" do
    odidown = 'vimeo[11911548]'
    assert Govspeak::Document.new(odidown).to_html.include? @@html
  end

  test "vimeo embed with generic embed tag" do
    odidown = 'embed[http://vimeo.com/11911548?whatever]'
    assert Govspeak::Document.new(odidown).to_html.include? @@html
  end
  
  test "vimeo embed with specified size" do
    odidown = 'embed[http://vimeo.com/11911548?whatever|200,100]'
    assert Govspeak::Document.new(odidown).to_html.include? 'width="200" height="100"'
  end

end
