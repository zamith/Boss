# It could be done with ::ActionView::Base.send :include, Boss::ApplicationHelper
# but it would not load the ApplicationHelper of Boss to the ancestors chain

require 'active_support/concern'

module BossHelpers
  extend ActiveSupport::Concern

  included do
    helper Boss::Engine.helpers
    helper_method :ac_helper
  end

  module ClassMethods
    def ac_helper
      @ac_helper ||= ActionController::Base.new
    end
  end
end

#::ApplicationController.send :include, BossHelpers
#::ApplicationController.send :extend, BossHelpers::ClassMethods

module ApplicationConfig
  extend ActiveSupport::Concern

  included do
    config.assets.precompile += ["jquery.ui.datepicker-pt-BR.js", "jquery.ui.datepicker-en-GB.js"]
  end
end

"#{Rails.application.class.parent_name}::Application".constantize.send :include, ApplicationConfig
