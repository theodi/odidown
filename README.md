ODIdown (pronounced like eiderdown) is a set of extensions to Markdown for use at the ODI.

It's built on top of [govspeak](http://github.com/alphagov/govspeak), and basically just patches their extension rather than building our own.

# Usage

Add it to your Gemfile

    gem "odidown", github: "theodi/odidown"

then create a new document

    require 'rubygems'
    require 'odidown'

    doc = Govspeak::Document.new "^Test^"
    puts doc.to_html

# Extensions

In addition to the [govspeak's extensions](http://github.com/alphagov/govspeak):

## iframe tags

iframe tags are allowed, for embedding things like Youtube videos.

## Video helpers

```
youtube:OZPTM0PGQPE
```