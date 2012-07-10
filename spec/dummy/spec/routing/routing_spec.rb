require "spec_helper"

describe "routing" do

  context "posts" do 
    it "should have a route to a new post" do
      get("posts/new").should route_to "boss/posts#new"
    end
  end

  context "resources" do
    it "should have a route to create an image" do
      post("resources/image").should route_to "boss/resources#create", :type => "image"
    end
    
    it "should have a route to list all images" do
      get("resources/images").should route_to "boss/resources#all_images"
    end
  end

end