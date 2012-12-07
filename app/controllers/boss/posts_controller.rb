class Boss::PostsController < Boss::ApplicationController
  load_and_authorize_resource :class => "Boss::Post"

  def index
    @posts = Boss::Post.posts_for_index
  end

  def show
    @post = Boss::Post.find params[:id]
  end

end