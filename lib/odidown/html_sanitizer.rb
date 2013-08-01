require 'govspeak/html_sanitizer'

class Govspeak::HtmlSanitizer
  def sanitize_config
    # Original code
    config = Sanitize::Config::RELAXED.dup
    config[:attributes][:all].push("id", "class")
    config[:attributes]["a"].push("rel")
    config[:elements].push("div", "hr")
    # We're event MORE relaxed at the ODI.
    # Let's allow iframes, for youtube embedding!
    config[:elements].push("iframe")
    config[:attributes]["iframe"] = ["src", "width", "height", "frameborder", "allowfullscreen"]
    # Done
    config
  end
end
