class Boss::Admin::BannersController < Boss::Admin::ApplicationController
  load_and_authorize_resource :class => "Boss::Banner"

  def index
    @banner = Boss::Banner.all
  end

  def show
    @banner = Boss::Banner.find(params[:id])
  end

  def new
    @banner = Boss::Banner.new
    @banner.build_image
  end

  def create
    @banner = Boss::Banner.new(params[:banner])
    if @banner.save
      flash[:notice] = t('banners.flash.saved')
      redirect_to boss.admin_banners_path
    else
      flash[:alert] = t('banners.flash.failed_to_save')
      render :new
    end
  end

  def edit
    @banner = Boss::Banner.find(params[:id])
  end

  def update
    @banner = Boss::Banner.find(params[:id])
    if @banner.update_attributes(params[:banner])
      flash[:notice] = t('banners.flash.updated')
      redirect_to boss.admin_banners_path
    else
      flash[:alert] = t('banners.flash.failed_to_update')
      render :edit
    end
  end

  def destroy
    @banner = Boss::Banner.find(params[:id])
    @banner.destroy

    redirect_to boss.admin_banners_path
  end
end
