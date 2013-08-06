require 'erb'
require 'ostruct'
require 'json'
require 'net/http'

class Govspeak::Document

  def youtube(id)
    erb('youtube', id: id, width: '560', height: '315')
  end

  def vimeo(id)
    erb('vimeo', id: id, width: '500', height: '375')
  end
  
  def soundcloud(id)
    erb('soundcloud', id: id, width: '100%', height: '166')
  end
  
  def slideshare(id)
    erb('slideshare', id: id, width: '427', height: '356')
  end
  
  # Extensions

  extension('youtube', surrounded_by("youtube[","]")) do |id|
    youtube(id)
  end

  extension('vimeo', surrounded_by("vimeo[","]")) do |id|
    vimeo(id)
  end

  extension('soundcloud', surrounded_by("soundcloud[","]")) do |body|
    soundcloud(body)
  end

  extension('slideshare', surrounded_by("slideshare[","]")) do |id|
    if id =~ /^https?:\/\//
      oembed = get_json "http://www.slideshare.net/api/oembed/2?url=#{id}&format=json"
      id = oembed['slideshow_id']
    end
    slideshare(id)
  end

  extension('video', surrounded_by("video[","]")) do |url|
    case url
      when /youtube\.com/
        id = url.split(/[\&\=]/)[1]
        youtube(id)
      when /vimeo.com/
        id = url.split(/[\/\?]/)[3]
        vimeo(id)     
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