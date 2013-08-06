require "test_helper"

class TwitterTest < Test::Unit::TestCase

  @@html = %{<blockquote class="twitter-tweet">
<p>Woop <a href="https://twitter.com/search?q=%23TheAshes&amp;src=hash">#TheAshes</a></p>- Sam (@pikesley) <a href="https://twitter.com/pikesley/statuses/364410577206403072">August 5, 2013</a>
</blockquote>
<script async="" src="//platform.twitter.com/widgets.js" charset="utf-8"></script>}

  test "allow twitter embeds" do
    assert_equal @@html, Govspeak::HtmlSanitizer.new(@@html).sanitize
  end

end
