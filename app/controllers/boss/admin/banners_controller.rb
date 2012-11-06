class Boss::Admin::BannersController < Boss::Admin::ApplicationController
  load_and_authorize_resource :class => "Boss::Banner"

  def new
    @banner = Boss::Banner.new
    @banner.build_image
  end

  def create
    @banner = Boss::Banner.new(params[:banner])
    if @banner.save
      flash[:notice] = t('banners.flash.saved')
      redirect_to admin_root_path
    else
      flash[:alert] = t('banners.flash.failed_to_save')
      render :new
    end
  end
end
