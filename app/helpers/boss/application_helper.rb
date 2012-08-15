module Boss
  module ApplicationHelper
    def ac_helper
      @ac_helper ||= ActionController::Base.new
    end

    def banner_viewer
      ac_helper.render_to_string(partial: "boss/banners/banner_viewer", locals: {banners: Boss::Banner.all}).html_safe
    end
  end
end
