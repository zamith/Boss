class Boss::Admin::ApplicationController < Boss::ApplicationController
  protect_from_forgery
  layout "admin/application-boss"
  
end