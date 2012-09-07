require "paperclip"
require "cancan"
require "acts-as-taggable-on"

module Boss
  class Engine < ::Rails::Engine
    isolate_namespace Boss
    
    config.i18n.load_path += Dir[Boss::Engine.root.join('config', 'locales', '**', '*.{rb,yml}')]
  end
end
