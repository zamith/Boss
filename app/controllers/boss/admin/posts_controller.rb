class Boss::Admin::PostsController < Boss::Admin::ApplicationController
  before_filter :check_if_admin

  def index
    @posts = Boss::Post.all
  end

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

  def destroy
    @post = Boss::Post.find params[:id]
    title = @post.title
    if @post.destroy
      flash[:notice] = t('posts.flash.destroyed', name: title)
    else
      flash[:error] = t('posts.flash.failed_to_destroy')
    end

    redirect_to boss.admin_posts_path
  end

  def save
    if session[:post_id]
      @post = Boss::Post.find session[:post_id]
      add_tags
      saved = @post.update_attributes body: params[:data], category_id: params[:category_id], title: params[:title]
    else
      @post = Boss::Post.new body: params[:data], title: params[:title], category_id: params[:category_id], draft: true
      add_tags
      @post.save
      saved = @post.persisted?
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
    saved = if params[:id]
      publish_from_index_or_edit
    else
      if session[:post_id]
        publish_saved_post
      else
        publish_unsaved_post
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

  private

  def check_if_admin
    authorize! :manage, Boss::Post
  end

  def publish_from_index_or_edit
    @post = Boss::Post.find params[:id]
    add_tags
    @post.update_attributes draft: false,
      published_date: Time.now
  end

  def publish_saved_post
    @post = Boss::Post.find session[:post_id]
    session.delete :post_id
    add_tags
    @post.update_attributes body: params[:data],
      title: params[:title],
      category_id: params[:category_id],
      draft: false,
      published_date: Time.now
  end

  def publish_unsaved_post
    @post = Boss::Post.new body: params[:data],
      title: params[:title],
      draft: false,
      category_id: params[:category_id],
      published_date: Time.now
    add_tags
    @post.save

    @post.persisted?
  end

  def add_tags
    unless params[:tags].blank?
      @post.tag_list = params[:tags]
    end
  end

end