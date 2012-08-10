require "boss/engine"

module Boss
  Dir["#{Engine.root}/lib/boss/*.rb"].each {|file| require file}
end
