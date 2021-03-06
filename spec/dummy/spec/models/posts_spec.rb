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

  context "category" do
    it "should have the default category" do
      a_post.category_id.should_not be_nil
      a_post.category.name.should == "Default"
    end

    it "should allow the change of category" do
      a_post.category_id = 2
      a_post.category_id.should eq 2
      a_post.should be_valid
    end
  end

  context 'posts for index' do
    it "should only return the first posts to show in the index page" do
      Boss::Post.posts_for_index.size.should be <= POSTS["index_limit"].to_i
    end

    it "should return the number of posts on demand" do
      Boss::Post.posts_for_index({ index_limit: 1 }).size.should be <= 1
    end
    
    it "should get posts with an offset" do
      Boss::Post.posts_for_index({ starts_at: 1 }).first.should == boss_posts(:second)
    end
  end

end
