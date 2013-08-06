require 'govspeak/html_sanitizer'

class Govspeak::HtmlSanitizer
  def sanitize_config
    # Original code
    config = Sanitize::Config::RELAXED.dup
    config[:attributes][:all].push("id", "class")
    config[:attributes]["a"].push("rel")
    config[:elements].push("div", "hr")
    # We're event MORE relaxed at the ODI.
    # Let's allow iframes, for embedding of various things!
    config[:elements].push("iframe")
    config[:attributes]["iframe"] = [ "src", "width", "height", "frameborder", 
                                      "allowfullscreen", "mozallowfullscreen", 
                                      "webkitallowfullscreen", "style", "marginwidth",
                                      "marginheight", "scrolling", "data-auto-height",
                                      "data-aspect-ratio", ]
    # Some things embed with scripts. This can't be a bad thing.
    config[:elements].push("script")
    config[:attributes]["script"] = [ "src", "async", "charset" ]
    # Done
    config
  end
end
