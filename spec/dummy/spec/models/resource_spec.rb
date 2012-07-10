require 'spec_helper'

describe Boss::Resource do
  
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
end