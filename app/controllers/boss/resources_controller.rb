class Boss::ResourcesController < Boss::ApplicationController
  load_and_authorize_resource :class => "Boss::Resource"
  respond_to :json

  def create
    if params[:type] == 'image'
      @resource = Boss::Resource.create_image params[:file]
      if @resource
        render text: { filelink: @resource.resource.url }.to_json
      else
        render status: 400
      end
    elsif params[:type] == 'file'
      @resource = Boss::Resource.create_file params[:file]
      if @resource
        render text: { filelink: @resource.resource.url, filename: @resource.resource_file_name }.to_json
      else
        render status: 400
      end
    else
      render status: 400
    end
  end

  def all_images
    @images = Boss::Resource.all_images
    @images_json = @images.map do |image|
      { "thumb" =>image.resource.url, "image" => image.resource.url }
    end

    respond_with @images_json
  end
end
