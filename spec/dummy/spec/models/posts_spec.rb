describe Boss::Post do
  
  context 'save' do
    it "should have a default value for the title" do
      post = Boss::Post.create body: "Hello", draft: true
      post.title.should_not be_nil
    end
  end
  
end