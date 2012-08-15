# It could be done with ::ActionView::Base.send :include, Boss::ApplicationHelper
# but it would not load the ApplicationHelper of Boss to the ancestors chain

module BossHelpers
  def self.included(base)
    base.instance_eval do
      helper Boss::Engine.helpers
    end
  end
end


::ApplicationController.send :include, BossHelpers
