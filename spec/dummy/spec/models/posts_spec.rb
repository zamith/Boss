describe Boss::Post do
  set_fixture_class :boss_posts => 'Boss::Post'
  fixtures :boss_posts

  let(:a_post) { boss_posts(:first) }

  context 'save' do
    it "should have a default value for the title" do
      post = Boss::Post.create body: "Hello", draft: true
      post.title.should_not be_nil
    end
  end

  context 'posts for index' do
    it "should only return the first posts to show in the index page" do
      Boss::Post.posts_for_index.size.should be <= 15
    end

    it "should return the number of posts on demand" do
      Boss::Post.posts_for_index({ no_of_users_in_index: 1 }).size.should be <= 1
    end
    
    it "should get posts with an offset" do
      Boss::Post.posts_for_index({ starts_at: 1 }).first.should == boss_posts(:second)
    end
  end

end
