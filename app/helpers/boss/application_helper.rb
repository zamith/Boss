module Boss
  module ApplicationHelper
    def self.ac_helper
      @ac_helper ||= ActionController::Base.new
    end

    def banner_viewer
      # ::ApplicationController.ac_helper.render_to_string(partial: "boss/banners/banner_viewer",
      #                                                    locals: {banners: Boss::Banner.all}).html_safe
      render partial: "boss/banners/banner_viewer", locals: {banners: Boss::Banner.all}
    end

    def include_i18n_calendar_javascript
      content_for :head do
        javascript_include_tag case I18n.locale
          when :en then "#{::ActionController::Base.helpers.asset_path('datepicker-locales/jquery.ui.datepicker-en-GB.js')}"
          when :pt then "#{::ActionController::Base.helpers.asset_path('datepicker-locales/jquery.ui.datepicker-pt-BR.js')}"
          else raise ArgumentError, "Locale error"
        end
      end
    end
  end
end
