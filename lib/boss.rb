require "boss/engine"

module Boss
  Dir["#{Engine.root}/lib/*.rb"].each {|file| require file}
end
