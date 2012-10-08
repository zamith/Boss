require 'spec_helper'

describe Boss::PostsController do
  set_fixture_class :boss_posts => 'Boss::Post'
  fixtures :boss_posts

  set_fixture_class :citygate_users => 'Citygate::User'
  fixtures :citygate_users

  let(:a_post) { boss_posts(:first) }
  let(:user) { citygate_users(:admin) }


  before (:each) do
    session.clear
    sign_in user
  end

  context "publish" do
    it "should redirect to posts index" do
      post :save, data: a_post.body, title: a_post.title
      post :publish, data: a_post.body, title: a_post.title

      response.should redirect_to posts_path
    end

    it "should redirect to the admin posts index if the request came from there" do
      post :publish, id: boss_posts(:first).id

      response.should redirect_to admin_posts_path
    end

    context "successful" do
      it "should be able to publish a post using the id in session" do
        post :save, data: a_post.body, title: a_post.title
        post :publish, data: a_post.body, title: a_post.title

        assigns(:post).body.should == a_post.body
        assigns(:post).title.should == a_post.title
        assigns(:post).draft.should be_false
      end

      it "should be able to publish a post without the id in session" do
        post :publish, data: a_post.body, title: a_post.title

        assigns(:post).body.should == a_post.body
        assigns(:post).title.should == a_post.title
        assigns(:post).draft.should be_false
      end

      it "should provide a flash notice when publishes a post" do
        post :save, data: a_post.body, title: a_post.title
        post :publish, data: a_post.body, title: a_post.title

        flash[:notice].should =~ /was published/i
      end

      it "should clean the session post_id" do
        post :publish, data: a_post.body, title: a_post.title

        session[:post_id].should be_nil
      end

      it "should be able to publish a post from the id in the url" do
        post :publish, id: boss_posts(:first).id

        assigns(:post).draft.should be_false
        assigns(:post).id.should == boss_posts(:first).id
      end
    end

    context "error" do
      it "should provide a flash notice when cannot publish a post" do
        post :save, data: a_post.body, title: a_post.title
        post :publish, data: nil

        flash[:error].should =~ /Could not publish the post/i
      end
    end

  end

  context "save" do

    it "should create a post as draft and add its id to the session if the session is empty" do
      session[:post_id] = nil
      post :save, data: a_post.body, title: a_post.title

      session[:post_id].should_not be_nil
      assigns(:post).draft.should be_true
      assigns(:post).body.should == a_post.body
      assigns(:post).title.should == a_post.title
    end

    it "should update an existing post if the session is not empty" do
      session[:post_id] = boss_posts(:first).id

      post :save, data: a_post.body, title: a_post.title

      session[:post_id].should == boss_posts(:first).id
      assigns(:post).draft.should be_true
      assigns(:post).body.should == a_post.body
      assigns(:post).title.should == a_post.title
    end

    it "should save the html code of a post" do
      post :save, data: a_post.body, title: a_post.title

      assigns(:response).should == { "flash_message" => "Saved Draft", "flash" => "notice", "redirect" => "/blog"}
      assigns(:post).body.should == a_post.body
    end

    it "should alert of the failure to create post" do
      post :save, data: nil

      session[:post_id].should be_nil
      assigns(:response)[:flash].should == "error"
    end

    it "should alert of the failure to update a post" do
      session[:post_id] = boss_posts(:first).id

      post :save, data: nil

      session[:post_id].should == boss_posts(:first).id
      assigns(:response)[:flash].should == "error"
    end

  end

  context "index" do
    it "should provide all the required posts to the view" do
      get :index

      assigns(:posts).should == Boss::Post.posts_for_index
    end
  end

  context "edit" do
    it "should load the post for editing" do
      get :edit, id: boss_posts(:first).id

      assigns(:post).body.should == boss_posts(:first).body
    end
  end

  context "content" do
    it "should return a json object with the post body" do
      get :content, id: boss_posts(:first).id

      assigns(:content).should == boss_posts(:first).body
    end
  end

  context "load" do
    it "should get posts to show in the index with a given offset" do
      get :load, starts_at: 1

      assigns(:posts).first.should == boss_posts(:second)
    end
  end

  context "show" do
    it "should get the correct post and show it" do
      get :show, id: boss_posts(:first).id

      assigns(:post).should == boss_posts(:first)
    end
  end

end
