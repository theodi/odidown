require 'govspeak/html_sanitizer'

class Govspeak::HtmlSanitizer
  def sanitize_config
    # Original code
    config = Sanitize::Config::RELAXED.dup
    config[:attributes][:all].push("id", "class", :data)
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
    # Allow forms (for Mailchimp embeds)
    config[:elements].push("form","input","label")
    config[:attributes]["form"] = ["action","method"]
    config[:attributes]["input"] = ["type","name","id","tabindex","value","class"]
    config[:attributes]["label"] = ["for"]
    config[:attributes]["div"] = ["style","aria-hidden"]

    # Allow mathml
    mathml_elements = [
      "math",
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
    ]
    mathml_attributes = [
      "accent",
      "accentunder",
      "actiontype",
      "align",
      "alignmentscope",
      "altimg",
      "altimg-width",
      "altimg-height",
      "altimg-valign",
      "alttext",
      "bevelled",
      "charalign",
      "close",
      "columnalign",
      "columnlines",
      "columnspacing",
      "columnspan",
      "columnwidth",
      "crossout",
      "decimalpoint",
      "denomalign",
      "depth",
      "dir",
      "display",
      "displaystyle",
      "edge",
      "encoding",
      "equalcolumns",
      "equalrows",
      "fence",
      "form",
      "frame",
      "framespacing",
      "groupalign",
      "height",
      "href",
      "id",
      "indentalign",
      "indentalignfirst",
      "indentalignlast",
      "indentshift",
      "indentshiftfirst",
      "indentshiftlast",
      "indenttarget",
      "infixlinebreakstyle",
      "largeop",
      "length",
      "linebreak",
      "linebreakmultchar",
      "linebreakstyle",
      "lineleading",
      "linethickness",
      "location",
      "longdivstyle",
      "lspace",
      "lquote",
      "mathbackground",
      "mathcolor",
      "mathsize",
      "mathvariant",
      "maxsize",
      "minlabelspacing",
      "minsize",
      "mode",
      "movablelimits",
      "notation",
      "numalign",
      "open",
      "overflow",
      "position",
      "rowalign",
      "rowlines",
      "rowspacing",
      "rowspan",
      "rspace",
      "rquote",
      "scriptlevel",
      "scriptminsize",
      "scriptsizemultiplier",
      "selection",
      "separator",
      "separators",
      "shift",
      "side",
      "src",
      "stackalign",
      "stretchy",
      "subscriptshift",
      "supscriptshift",
      "symmetric",
      "voffset",
      "width",
      "xlink:href",
      "xmlns"
    ]
    config[:elements].push(*mathml_elements)
    mathml_elements.each do |element|
      config[:attributes][element] = mathml_attributes
    end
    # Done
    config
  end
end
