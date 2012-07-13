require 'spec_helper'

describe Boss::PostsController do
  before (:each) do
    @html = "<div><a href='#'>Link</a></div>"
    session.clear
  end

  context "publish" do
    it "should redirect to posts index" do
      post :save, data: @html
      post :publish, data: @html
      
      response.should redirect_to posts_path
    end
    
    context "successful" do
      it "should be able to publish a post using the id in session" do
        post :save, data: @html
        post :publish, data: @html
        
        assigns(:post).body.should == @html
        assigns(:post).draft.should be_false
      end
      
      it "should be able to publish a post without the id in session" do
        post :publish, data: @html
        
        assigns(:post).body.should == @html
        assigns(:post).draft.should be_false
      end
      
      it "should provide a flash notice when publishes a post" do
        post :save, data: @html
        post :publish, data: @html
        
        flash[:notice].should =~ /was published/i
      end
      
      it "should clean the session post_id" do
        post :publish, data: @html
        
        session[:post_id].should be_nil
      end
    end
    
    context "error" do
      it "should provide a flash notice when cannot publish a post" do
        post :save, data: @html
        post :publish, data: nil
        
        flash[:error].should =~ /Could not publish the post/i
      end
    end

  end

  context "save" do
    
    it "should create a post as draft and add its id to the session if the session is empty" do
      session[:post_id] = nil
      post :save, data: @html
      
      session[:post_id].should_not be_nil
      assigns(:post).draft.should be_true
    end
    
    it "should update an existing post if the session is not empty" do
      post_obj = Boss::Post.create(body: "Hello", draft: true)
      session[:post_id] = post_obj.id
      
      post :save, data: @html
      
      session[:post_id].should == post_obj.id
      assigns(:post).draft.should be_true
      assigns(:post).body.should == @html
    end

    it "should save the html code of a post" do
      post :save, data: @html
    
      assigns(:response).should == { "flash_message" => "Saved Draft", "flash" => "notice"}
      assigns(:post).body.should == @html
    end

    it "should alert of the failure to create post" do
      post :save, data: nil
      
      session[:post_id].should be_nil
      assigns(:response)[:flash].should == "error"
    end
    
    it "should alert of the failure to update a post" do
      post_obj = Boss::Post.create(body: "Hello", draft: true)
      session[:post_id] = post_obj.id
      
      post :save, data: nil
      
      session[:post_id].should == post_obj.id
      assigns(:response)[:flash].should == "error"
    end

  end

end