require "test_helper"

class ExtensionsTest < Test::Unit::TestCase

  test "youtube extension" do
    odidown = 'youtube[OZPTM0PGQPE]'
    target_html = '<iframe width="560" height="315" src="//www.youtube.com/embed/OZPTM0PGQPE" frameborder="0" allowfullscreen=""></iframe>'
    assert Govspeak::Document.new(odidown).to_html.include? target_html
  end
  
  test "vimeo extension" do
    odidown = 'vimeo[11911548]'
    target_html = '<iframe src="http://player.vimeo.com/video/11911548" width="500" height="375" frameborder="0" webkitallowfullscreen="" mozallowfullscreen="" allowfullscreen=""></iframe>'
    assert Govspeak::Document.new(odidown).to_html.include? target_html
  end
  
  test "soundcloud extension" do
    odidown = 'soundcloud[81761778]'
    target_html = '<iframe width="100%" height="166" frameborder="no" src="https://w.soundcloud.com/player/?url=http%3A%2F%2Fapi.soundcloud.com%2Ftracks%2F81761778"></iframe>'
    assert Govspeak::Document.new(odidown).to_html.include? target_html
  end

  test "youtube embed with generic video tag" do
    odidown = 'video[https://www.youtube.com/watch?v=OZPTM0PGQPE&feature=player_detailpage&t=389]'
    target_html = '<iframe width="560" height="315" src="//www.youtube.com/embed/OZPTM0PGQPE" frameborder="0" allowfullscreen=""></iframe>'
    assert Govspeak::Document.new(odidown).to_html.include? target_html
  end
  
  test "vimeo embed with generic video tag" do
    odidown = 'video[http://vimeo.com/11911548?whatever]'
    target_html = '<iframe src="http://player.vimeo.com/video/11911548" width="500" height="375" frameborder="0" webkitallowfullscreen="" mozallowfullscreen="" allowfullscreen=""></iframe>'
    assert Govspeak::Document.new(odidown).to_html.include? target_html
  end
  
end
