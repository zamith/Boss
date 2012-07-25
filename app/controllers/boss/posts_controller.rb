class Boss::PostsController < ApplicationController

  def new
    @post = Boss::Post.new
    session.delete :post_id
  end
  
  def edit
    @post = Boss::Post.find params[:id]
    session[:post_id] = params[:id]
  end

  def index
    @posts = Boss::Post.all
  end

  def save
    if session[:post_id]
      @post = Boss::Post.find session[:post_id]
      saved = @post.update_attributes body: params[:data], title: params[:title]
    else
      @post = Boss::Post.create body: params[:data], title: params[:title], draft: true
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
        saved = @post.update_attributes body: params[:data], title: params[:title], draft: false
        session.delete :post_id
      else
        @post = Boss::Post.create body: params[:data], title: params[:title], draft: false
        saved = (@post.id) ? true : false
      end
    end


    if saved
      flash[:notice] = t('posts.flash.published_post', title: @post.title)
    else
      flash[:error] = t('posts.flash.failed_to_published_post')
    end

    redirect_to (params[:id]) ? admin_posts_path : posts_path
  end
  
  def content
    @post = Boss::Post.find params[:id]
    @content = @post.body
    
    respond_to do |format|
      format.json { render json: @content.to_json }
    end
  end
  
end