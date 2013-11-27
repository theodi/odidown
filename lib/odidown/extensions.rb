require 'erb'
require 'ostruct'
require 'json'
require 'net/http'

class Govspeak::Document

  def youtube(id)
    id, width, height = dimensions(id,'560','315')
    if id =~ /youtube.com/
      id = id.split(/[\&\=]/)[1]
    elsif id =~ /youtu.be/
      id = id.split(/[\/\?]/)[3]
    end
    erb('youtube', id: id, width: width, height: height)
  end

  def vimeo(id)
    id, width, height = dimensions(id,'500','375')
    if id =~ /^https?:\/\//
      id = id.split(/[\/\?]/)[3]
    end
    erb('vimeo', id: id, width: width, height: height)
  end
  
  def soundcloud(id)
    id, width, height = dimensions(id,'100%','166')
    if id =~ /^https?:\/\//
      oembed = get_json "http://soundcloud.com/oembed?url=#{id}&format=json"
      id = oembed['html'].match(/tracks%2F([0-9]*?)&/)[1]
    end
    erb('soundcloud', id: id, width: width, height: height)
  end
  
  def slideshare(id)
    id, width, height = dimensions(id,'427','356')
    if id =~ /^https?:\/\//
      oembed = get_json "http://www.slideshare.net/api/oembed/2?url=#{id}&format=json"
      id = oembed['slideshow_id']
    end
    erb('slideshare', id: id, width: width, height: height)
  end
  
  def scribd(id)
    id, width, height = dimensions(id,'100%','600')
    if id =~ /^https?:\/\//
      id = id.match(/\/doc\/([0-9]*)/)[1]
    end
    erb('scribd', id: id, width: width, height: height)
  end
  
  def livestream(url)
    url, width, height = dimensions(url,'640','360')
    if url =~ /^https?:\/\//
      html = Net::HTTP.get(URI.parse(url))
      re = /livestream.com\/accounts\/([0-9]*)\/events\/([0-9]*)/
      account = html.match(re)[1]
      event = html.match(re)[2]
      erb('livestream', account: account, event: event, width: width, height: height)
    end
  end
  
  def storify(url)
    if url =~ /^https?:\/\//
      path = url.match(/storify.com\/([^\?]*)/)[1]
      erb('storify', path: path)
    end
  end

  def attachment(attachment, url, alt_text, classes)
    erb('attachment', url: url, attachment: attachment, alt_text: alt_text, classes: classes)
  end
  
  # Extensions

  [
    :youtube,
    :vimeo,
    :soundcloud,
    :slideshare,
    :scribd,
    :livestream,
    :storify,
  ].each do |service|
    extension(service.to_s, surrounded_by("#{service}[","]")) do |id|
      send(service, id)
    end
  end

  # Image Attachments
  extension('attachment', surrounded_by("attachment[","]")) do |params|
    id, attachment, alt_text, classes= params.split(', ')
    attachment(id, attachment, alt_text, classes)
  end

  # Generic extension

  extension('embed', surrounded_by("embed[","]")) do |url|
    case url
      when /youtube\.com/,  /youtu\.be/
        youtube(url)
      when /vimeo\.com/
        vimeo(url)     
      when /soundcloud\.com/
        soundcloud(url)
      when /slideshare\.net/
        slideshare(url)
      when /scribd\.com/
        scribd(url)
      when /livestream\.com/
        livestream(url)
      when /storify\.com/
        storify(url)
      else
        ''
    end
  end

  private
  
  class ErbRenderer < OpenStruct
    def render(template)
      ERB.new(template).result(binding)
    end
  end

  def erb(template, options)
    renderer = ErbRenderer.new(options)
    renderer.render(File.read(File.join(File.dirname(__FILE__), '..', '..', 'views', "#{template}.erb"))) 
  end

  def get_json(url)
    JSON.parse(Net::HTTP.get(URI.parse(url)))
  end
  
  def dimensions(str, default_width, default_height)
    match = str.match /([^\|].*)\|([0-9\%px]*)\,([0-9\%px]*)/
    if match
      str = match[1]
      width = match[2]
      height = match[3]
    else
      width = default_width
      height = default_height
    end
    [str, width, height]
  end

end
