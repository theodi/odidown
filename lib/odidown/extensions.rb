require 'erb'
require 'ostruct'
require 'json'
require 'net/http'

class Govspeak::Document

  def youtube(id)
    if id =~ /youtube.com/
      id = id.split(/[\&\=]/)[1]
    elsif id =~ /youtu.be/
      id = id.split(/[\/\?]/)[3]
    end
    erb('youtube', id: id, width: '560', height: '315')
  end

  def vimeo(id)
    if id =~ /^https?:\/\//
      id = id.split(/[\/\?]/)[3]
    end
    erb('vimeo', id: id, width: '500', height: '375')
  end
  
  def soundcloud(id)
    if id =~ /^https?:\/\//
      oembed = get_json "http://soundcloud.com/oembed?url=#{id}&format=json"
      id = oembed['html'].match(/tracks%2F([0-9]*?)&/)[1]
    end
    erb('soundcloud', id: id, width: '100%', height: '166')
  end
  
  def slideshare(id)
    if id =~ /^https?:\/\//
      oembed = get_json "http://www.slideshare.net/api/oembed/2?url=#{id}&format=json"
      id = oembed['slideshow_id']
    end
    erb('slideshare', id: id, width: '427', height: '356')
  end
  
  def scribd(id)
    if id =~ /^https?:\/\//
      id = id.match(/\/doc\/([0-9]*)/)[1]
    end
    erb('scribd', id: id, width: '100%', height: '600')
  end
  
  def livestream(id)
    
  end
  
  # Extensions

  [
    :youtube,
    :vimeo,
    :soundcloud,
    :slideshare,
    :scribd,
  ].each do |service|
    extension(service.to_s, surrounded_by("#{service}[","]")) do |id|
      send(service, id)
    end
  end

  # Generic extension

  extension('video', surrounded_by("video[","]")) do |url|
    case url
      when /youtube\.com/,  /youtu\.be/
        youtube(url)
      when /vimeo\.com/
        vimeo(url)     
      when /livestream\.com/
        livestream(url)
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

end