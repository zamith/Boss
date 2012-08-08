class PostGenerator

  def initialize(*args)
    @html = ""
    yield.each do |elem|
      send elem
    end
  end

  def generate
    begin
      file = File.open("#{Boss::Engine.root}/app/views/boss/posts/show.html.erb", "wb")
      file.write @html
    ensure
      file.close
    end
  end

  def method_missing(method, *args)
    begin
      file = File.open("#{Boss::Engine.root}/app/views/boss/posts/_#{method.to_s}.html.erb", "rb")
      @html += file.read
      @html += "\n"
      file.close
    rescue
      super
    end
  end

end
