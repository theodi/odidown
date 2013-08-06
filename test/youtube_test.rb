require "test_helper"

class YouTubeTest < Test::Unit::TestCase

  @@html = %{<iframe width="560" height="315" src="https://www.youtube.com/embed/OZPTM0PGQPE" frameborder="0" allowfullscreen=""></iframe>}

  test "allow youtube embeds" do
    assert_equal @@html, Govspeak::HtmlSanitizer.new(@@html).sanitize
  end

  test "youtube extension" do
    odidown = 'youtube[OZPTM0PGQPE]'
    assert Govspeak::Document.new(odidown).to_html.include? @@html
  end

  test "youtube embed with generic video tag" do
    odidown = 'video[https://www.youtube.com/watch?v=OZPTM0PGQPE&feature=player_detailpage&t=389]'
    assert Govspeak::Document.new(odidown).to_html.include? @@html
  end
  
end
