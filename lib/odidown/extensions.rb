class Govspeak::Document

  extension('youtube', surrounded_by("youtube[","]")) do |body|
    %{<div><iframe width="560" height="315" src="//www.youtube.com/embed/#{body}" frameborder="0" allowfullscreen=""></iframe></div>}
  end

  extension('soundcloud', surrounded_by("soundcloud[","]")) do |body|
    %{<div><iframe width="100%" height="166" frameborder="no" src="https://w.soundcloud.com/player/?url=http%3A%2F%2Fapi.soundcloud.com%2Ftracks%2F#{body}"></iframe></div>
}
  end

end