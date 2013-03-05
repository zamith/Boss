require 'spec_helper'

describe Boss::PostsController do
  set_fixture_class :boss_posts => 'Boss::Post'
  fixtures :boss_posts

  let(:a_post) { boss_posts(:first) }


  context "index" do
    it "should provide all the required posts to the view" do
      get :index

      assigns(:posts).should == Boss::Post.posts_for_index(conditions: { draft: false })
    end
  end

  context "show" do
    it "should get the correct post and show it" do
      get :show, id: boss_posts(:first).id

      assigns(:post).should == boss_posts(:first)
    end
  end
end
