# encoding: UTF-8

require "test_helper"

class MailchimpTest < Test::Unit::TestCase

  test "stripped down mailchimp form" do
    form = <<-EOF
    <form action="//theodi.us6.list-manage.com/subscribe/post?u=84bd941af2f1389b9b88c66bb&amp;id=8024535a71" method="post">
      <label for="mce-EMAIL">Email Address *</label>
      <input type="email" name="EMAIL" id="mce-EMAIL">
      <div style="position: absolute; left: -5000px;" aria-hidden="true"><input type="text" name="b_84bd941af2f1389b9b88c66bb_8024535a71" tabindex="-1" value=""></div>
      <input type="submit" value="Subscribe" name="subscribe" id="mc-embedded-subscribe" class="button">
    </form>
    EOF
    assert_equal w(form), w(Govspeak::HtmlSanitizer.new(form).sanitize)
  end

  def w(str)
    str.gsub(/\>\s*/, ">").gsub(/\s*\</, "<")
  end

end
