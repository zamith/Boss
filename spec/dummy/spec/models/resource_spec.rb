require 'spec_helper'

describe Boss::Resource do
  
  it "should add the extension of the resource being created" do
    Boss::Resource.create_file fixture_file_upload('/files/basketball.pdf', 'application/pdf')
    
    Boss::Resource.last.extension.should == "pdf"
  end
  
  context 'images' do
    it "should create a new image given an ActionDispatch::Http::UploadedFile" do
      expect {
        Boss::Resource.create_image fixture_file_upload('/files/computer_0050.jpg', 'image/jpeg')
      }.to change{Boss::Resource.count}.by(1)
    end
    
    it "should not create a new image if the file format is not allowed" do
      expect {
        Boss::Resource.create_image fixture_file_upload('/files/basketball.pdf', 'application/pdf')
      }.not_to change{Boss::Resource.count}
    end
    
    it "should be able to get all images from the database" do
      image = Boss::Resource.create_image fixture_file_upload('/files/computer_0050.jpg', 'image/jpeg')
      other_file = Boss::Resource.create_file fixture_file_upload('/files/basketball.pdf', 'application/pdf')
      images = Boss::Resource.all_images
      
      images.should include(image)
      images.should_not include(other_file)
    end
  end
  
  context 'files' do
    it "should create a new file given an ActionDispatch::Http::UploadedFile" do
      expect {
        Boss::Resource.create_file fixture_file_upload('/files/basketball.pdf', 'application/pdf')
      }.to change{Boss::Resource.count}.by(1)
    end
  end
  
  context "resources for index" do
    before :each do
      @file = Boss::Resource.create_file fixture_file_upload('/files/basketball.pdf', 'application/pdf')
      @image = Boss::Resource.create_image fixture_file_upload('/files/computer_0050.jpg', 'image/jpeg')
    end
    
    it "should only return the first resources to show in the index page" do
      Boss::Resource.resources_for_index.size.should be <= RESOURCES["index_limit"].to_i
    end

    it "should return the number of resources on demand" do
      Boss::Resource.resources_for_index({ index_limit: 1 }).size.should be <= 1
    end
    
    it "should get posts with an offset" do
      Boss::Resource.resources_for_index({ starts_at: 1 }).first.should == @image
    end
  end
end