require "test_helper"

class SoundcloudTest < Test::Unit::TestCase

  @@html = %{<iframe width="100%" height="166" frameborder="no" src="https://w.soundcloud.com/player/?url=http%3A%2F%2Fapi.soundcloud.com%2Ftracks%2F81761778"></iframe>}

  test "allow soundcloud embeds" do
    assert_equal @@html, Govspeak::HtmlSanitizer.new(@@html).sanitize
  end

  test "soundcloud extension" do
    odidown = 'soundcloud[81761778]'
    assert Govspeak::Document.new(odidown).to_html.include? @@html
  end

end
