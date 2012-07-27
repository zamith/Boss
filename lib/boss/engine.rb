require "paperclip"
require "cancan"

module Boss
  class Engine < ::Rails::Engine
    isolate_namespace Boss
    
    config.i18n.load_path += Dir[Boss::Engine.root.join('config', 'locales', '**', '*.{rb,yml}')]
  end
end
