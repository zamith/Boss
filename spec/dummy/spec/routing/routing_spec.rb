require "spec_helper"

describe "routing" do

  context "posts" do
    it "should have a route to a new post" do
      get("admin/blog/new").should route_to "boss/admin/posts#new"
    end

    it "should have a route to save a post with the json format" do
      post("admin/blog/save").should route_to "boss/admin/posts#save", format: "json"
    end

    it "should not have a route to save a post with the html format" do
      post("admin/blog/save.html").should_not be_routable
    end

    it "should have a route to publish a post" do
      post("admin/blog/publish").should route_to "boss/admin/posts#publish"
    end

    it "should have a route to publish a post with id" do
      post("admin/blog/1/publish").should route_to("boss/admin/posts#publish", id: "1")
    end

    it "should have a route to get the content of a post" do
      get("admin/blog/1/content").should route_to("boss/admin/posts#content", id: "1")
    end

    it "should have a route to load the posts" do
      get("admin/blog/load").should route_to("boss/admin/posts#load")
    end

    it "should have a list to admin posts" do
      get("admin/blog").should route_to "boss/admin/posts#index"
    end
  end

  context "resources" do
    it "should have a route to create an image" do
      post("resources/image").should route_to "boss/resources#create", type: "image"
    end

    it "should have a route to list all images" do
      get("resources/images").should route_to "boss/resources#all_images"
    end

    context "admin" do
      it "should have a route to load the posts" do
        get("admin/resources/load").should route_to("boss/admin/resources#load")
      end

      it "should have a list to admin resources" do
        get("admin/resources").should route_to "boss/admin/resources#index"
      end
    end
  end

end