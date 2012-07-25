class Boss::Admin::PostsController < ApplicationController
  
  def index
    @posts = Boss::Post.all
  end
  
end