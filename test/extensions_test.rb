require "test_helper"

class ExtensionsTest < Test::Unit::TestCase

  test "youtube extension" do
    odidown = 'youtube[OZPTM0PGQPE]'
    target_html = '<iframe width="560" height="315" src="//www.youtube.com/embed/OZPTM0PGQPE" frameborder="0" allowfullscreen=""></iframe>'
    assert Govspeak::Document.new(odidown).to_html.include? target_html
  end

end
