module Boss
  module ApplicationHelper
    def banner_viewer
      ActionController::Base.new.render_to_string(partial: "boss/banners/banner_viewer", locals: {banners: Boss::Banner.all}).html_safe
    end
  end
end
