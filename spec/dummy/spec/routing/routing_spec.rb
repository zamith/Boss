require "spec_helper"

describe "routing" do

  context "posts" do 
    it "should have a route to a new post" do
      get("posts/new").should route_to "boss/posts#new"
    end
    
    it "should have a route to save a post with the json format" do
      post("posts/save").should route_to "boss/posts#save", format: "json"
    end
    
    it "should not have a route to save a post with the html format" do
      post("posts/save.html").should_not be_routable
    end
    
    it "should have a route to publish a post" do
      post("posts/publish").should route_to "boss/posts#publish"
    end
    
    it "should have a route to publish a post with id" do
      post("posts/1/publish").should route_to("boss/posts#publish", id: "1")
    end
    
    it "should have a route to get the content of a post" do
      get("posts/1/content").should route_to("boss/posts#content", id: "1")
    end
    
    context "admin" do
      it "should have a list to admin posts" do
        get("admin/posts").should route_to "boss/admin/posts#index"
      end
    end
  end

  context "resources" do
    it "should have a route to create an image" do
      post("resources/image").should route_to "boss/resources#create", type: "image"
    end
    
    it "should have a route to list all images" do
      get("resources/images").should route_to "boss/resources#all_images"
    end
  end

end