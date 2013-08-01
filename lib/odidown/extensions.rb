class Govspeak::Document

  extension('youtube', surrounded_by("youtube[","]")) do |body|
    %{<iframe width="560" height="315" src="//www.youtube.com/embed/#{body}" frameborder="0" allowfullscreen=""></iframe>}
  end

end