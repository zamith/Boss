class Boss::Admin::PostsController < Boss::Admin::ApplicationController
  before_filter :check_if_admin
  
  def index
    @posts = Boss::Post.all
  end
  
  protected
  
  def check_if_admin
    authorize! :manage, Boss::Post
  end
  
end