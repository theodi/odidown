require "test_helper"

class LivestreamTest < Test::Unit::TestCase

  @@html = %{<iframe src="http://new.livestream.com/accounts/135982/events/2288116/player?width=640&amp;height=360&amp;autoPlay=true&amp;mute=false" width="640" height="360" frameborder="0" scrolling="no"> </iframe>}

  test "allow livestream embeds" do
    assert_equal @@html, Govspeak::HtmlSanitizer.new(@@html).sanitize
  end

  test "livestream extension with URL" do
    odidown = 'livestream[http://new.livestream.com/DEN/events/2288116]'
    assert Govspeak::Document.new(odidown).to_html.include? @@html
  end

  test "video extension with livestream URL" do
    odidown = 'embed[http://new.livestream.com/DEN/events/2288116]'
    assert Govspeak::Document.new(odidown).to_html.include? @@html
  end

end
