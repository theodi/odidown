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

In addition to the [govspeak extensions](http://github.com/alphagov/govspeak):

## Tags

`iframe` and `script` tags are allowed, for embedding things like Youtube videos and tweets.

## Embedding

We also have a nice helper for embedding content from a number of different services:

```
embed[https://www.youtube.com/watch?v=aeaZ3_UN18g]
```

The embed syntax above supports the following services:

* Youtube (inc. Hangouts on Air)
* Vimeo
* Soundcloud
* Slideshare
* Scribd
* Livestream
* Storify

Just paste in the content page URL, and the code will do the rest. You can specify a size like so, either in pixels, or %:

```
embed[https://www.youtube.com/watch?v=aeaZ3_UN18g|200,100]
embed[https://www.youtube.com/watch?v=aeaZ3_UN18g|100%,400]
```

All embed sources support width/height, except:

* Storify