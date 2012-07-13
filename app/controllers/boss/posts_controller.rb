class Boss::PostsController < ApplicationController

  def new
    @post = Boss::Post.new
    session.delete :post_id
  end

  def save
    if session[:post_id]
      @post = Boss::Post.find session[:post_id]
      saved = @post.update_attributes body: params[:data]
    else
      @post = Boss::Post.create body: params[:data], draft: true
      saved = (@post.id) ? true : false
      session[:post_id] = @post.id if saved
    end

    @response = (saved) ? 
      { flash_message: t('posts.flash.saved_draft'), flash: "notice" } : 
      { flash_message: t('posts.flash.failed_to_save'), flash: "error" }

    respond_to do |format|
      format.json { render json: @response.to_json }
    end
  end
  
  def publish
    # TODO: publish w/o session, id comes by post
    p params
    if session[:post_id]
      @post = Boss::Post.find session[:post_id]
      saved = @post.update_attributes body: params[:data], draft: false
      session.delete :post_id
    else
      @post = Boss::Post.create body: params[:data], draft: false
      saved = (@post.id) ? true : false
    end


    if saved
      flash[:notice] = t('posts.flash.published_post', title: @post.title)
    else
      flash[:error] = t('posts.flash.failed_to_published_post')
    end

    redirect_to posts_path
  end
  
end