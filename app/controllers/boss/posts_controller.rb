class Boss::PostsController < Boss::ApplicationController
  load_and_authorize_resource :class => "Boss::Post"

  def new
    @post = Boss::Post.new
    @categories = Boss::Category.all
    session.delete :post_id
  end
  
  def edit
    @post = Boss::Post.find params[:id]
    @categories = Boss::Category.all
    session[:post_id] = params[:id]
  end

  def index
    @posts = Boss::Post.posts_for_index
  end

  def save
    if session[:post_id]
      @post = Boss::Post.find session[:post_id]
      saved = @post.update_attributes body: params[:data], category_id: params[:category_id], title: params[:title]
    else
      @post = Boss::Post.create body: params[:data], title: params[:title], category_id: params[:category_id], draft: true
      saved = (@post.id) ? true : false
      session[:post_id] = @post.id if saved
    end

    @response = (saved) ? 
      { flash_message: t('posts.flash.saved_draft'), flash: "notice", redirect: posts_path } : 
      { flash_message: t('posts.flash.failed_to_save'), flash: "error" }

    respond_to do |format|
      format.json { render json: @response.to_json }
    end
  end
  
  def publish
    if params[:id]
      @post = Boss::Post.find params[:id]
      saved = @post.update_attributes draft: false
    else
      if session[:post_id]
        @post = Boss::Post.find session[:post_id]
        saved = @post.update_attributes body: params[:data], title: params[:title], category_id: params[:category_id], draft: false
        session.delete :post_id
      else
        @post = Boss::Post.create body: params[:data], title: params[:title], category_id: params[:category_id], draft: false
        saved = (@post.id) ? true : false
      end
    end

    if saved
      flash[:notice] = t('posts.flash.published_post', title: @post.title)
    else
      flash[:error] = t('posts.flash.failed_to_published_post')
    end

    redirect_to (params[:id]) ? boss.admin_posts_path : boss.posts_path
  end
  
  def content
    @post = Boss::Post.find params[:id]
    @content = @post.body
    
    respond_to do |format|
      format.json { render json: @content.to_json }
    end
  end
  
  def load
    @posts = Boss::Post.posts_for_index({ starts_at: params[:starts_at] })
    
    html_str = render_to_string( partial: "boss/posts/post", collection: @posts)
        
    respond_to do |format|
      format.json { render json: { html: html_str, has_more: !@posts.empty?, new_start: (@posts.last) ? @posts.last.id : nil } }
    end
  end
  
  def show
    @post = Boss::Post.find params[:id]
  end
  
end