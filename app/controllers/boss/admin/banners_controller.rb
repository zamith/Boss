class Boss::Admin::BannersController < Boss::Admin::ApplicationController
  load_and_authorize_resource :class => "Boss::Banner"

  def new
    @banner = Boss::Banner.new
    @banner.build_image
  end
end