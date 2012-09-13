class Boss::Admin::ApplicationController < Boss::ApplicationController
  protect_from_forgery
  layout :set_layout

  private
  def set_layout
    if request.headers['X-NO-LAYOUT']
      false
    else
      "admin"
    end
  end
  
end