module Boss
  class PostGenerator

    def initialize(*args)
      @html = "<%# This file was generated, please do not edit unless you are sure of what you're doing %>\n\n<% post ||= @post %>\n\n"
      yield.each do |elem|
        send elem
      end
    end

    def generate
      begin
        file = File.open("#{Boss::Engine.root}/app/views/boss/posts/show.html.erb", "wb")
        file.write @html
        file.close
      rescue
        puts "Could not generate post template"
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
end
