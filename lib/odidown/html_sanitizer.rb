require 'govspeak/html_sanitizer'

class Govspeak::HtmlSanitizer
  def sanitize_config
    # Original code
    config = Sanitize::Config::RELAXED.dup
    config[:attributes][:all].push("id", "class")
    config[:attributes]["a"].push("rel")
    config[:elements].push("div", "hr", "table", "colgroup", "thead", "tbody", "th", "td", "tr", "col", "section", "span", "address")
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
    # Allow mathml
    config[:elements].push("math")
    config[:attributes]["math"] = [ "xmlns", "mode" ] 
    config[:elements].push(
      "maction", 
      "maligngroup", 
      "malignmark", 
      "menclose", 
      "merror", 
      "mfenced", 
      "mfrac", 
      "mglyph", 
      "mi", 
      "mlabeledtr", 
      "mlongdiv", 
      "mmultiscripts", 
      "mn", 
      "mo", 
      "mover", 
      "mpadded", 
      "mphantom", 
      "mroot", 
      "mrow", 
      "ms", 
      "mscarries", 
      "mscarry", 
      "msgroup", 
      "msline", 
      "mspace", 
      "msqrt", 
      "msrow", 
      "mstack", 
      "mstyle", 
      "msub", 
      "msup", 
      "msubsup", 
      "mtable", 
      "mtd", 
      "mtext", 
      "mtr", 
      "munder", 
      "munderover", 
      "semantics", 
      "annotation", 
      "annotation-xml", 
    )
    config[:attributes]["annotation"] = [ "encoding" ] 
    config[:attributes]["mo"] = [ "form" ] 
    # Done
    config
  end
end
