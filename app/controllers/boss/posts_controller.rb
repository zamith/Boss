class Boss::PostsController < ApplicationController
  
  def new
    @post = Boss::Post.new
  end
  
end