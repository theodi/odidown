class Govspeak::Document

  def youtube(id)
    %{<div><iframe width="560" height="315" src="//www.youtube.com/embed/#{id}" frameborder="0" allowfullscreen=""></iframe></div>}
  end

  extension('youtube', surrounded_by("youtube[","]")) do |body|
    youtube(body)
  end

  extension('soundcloud', surrounded_by("soundcloud[","]")) do |body|
    %{<div><iframe width="100%" height="166" frameborder="no" src="https://w.soundcloud.com/player/?url=http%3A%2F%2Fapi.soundcloud.com%2Ftracks%2F#{body}"></iframe></div>
}
  end

  extension('video', surrounded_by("video[","]")) do |url|
    case url
      when /youtube\.com/
        id = url.split(/[\&\=]/)[1]
        youtube(id)
      else
        ''
    end
  end

end