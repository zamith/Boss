require 'spec_helper'

describe Boss::ResourcesController do
  
  context "create" do
    
    it "should create an image when the type is image and the file is valid" do
      resource = double(:content_type => "image/png", :url => "/some/url")
      file = double(:resource => resource)
      Boss::Resource.should_receive(:create_image).and_return(file)
      
      post :create, :type => "image"
      assigns(:resource).resource.content_type.should == "image/png"
    end
    
    it "should create a file when the type is file and the file is valid" do
      resource = double(:content_type => "application/pdf", :url => "/some/url")
      file = double(:resource => resource)
      Boss::Resource.should_receive(:create_file).and_return(file)
      
      post :create, :type => "file"
      assigns(:resource).resource.content_type.should == "application/pdf"
    end
    
  end
  
  context "all_images" do
    
    it "should return all the images in the database" do
      resource = double(:content_type => "image/png", :url => "/some/url")
      image = mock_model(Boss::Resource)
      image.stub!(:resource => resource)
      Boss::Resource.should_receive(:all_images).and_return([image])

      get :all_images
      assigns(:images).should == [image]
    end
    
  end
end