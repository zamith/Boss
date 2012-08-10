class Boss::Admin::ResourcesController < Boss::Admin::ApplicationController
  load_and_authorize_resource :class => "Boss::Resource"

  def index
    @resources = Boss::Resource.resources_for_index
  end

  def create
    @file = Boss::Resource.new params[:resource]
    if @file.save
      render :json => [{
        :url => @file.resource.url.to_s,
        :thumbnail_url => ActionController::Base.helpers.asset_path("boss/icons/avi/avi-64-16.png"),
        :name => @file.resource.instance.attributes["resource_file_name"],
        :delete_url => admin_resource_path(@file),
        :delete_type => "DELETE"
      }], :content_type => 'text/html'
    else
      render :json => { :result => 'error'}, :content_type => 'text/html'
    end
  end
  
  def destroy
    @file = Boss::Resource.find params[:id]
    @file.destroy
    render :json => { :result => true }, :content_type => 'application/json'
  end

end
