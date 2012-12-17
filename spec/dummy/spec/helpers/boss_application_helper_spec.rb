require 'spec_helper.rb'

describe Boss::ApplicationHelper do
  set_fixture_class :boss_banners => 'Boss::Banner'
  fixtures :boss_banners

  let(:banner) { boss_banners(:first) }


  context "banner viewer" do
    it "should return a string with the html for all the banners" do
      Boss::Resource.create_image fixture_file_upload('/files/computer_0050.jpg', 'image/jpeg')
      Boss::Banner.should_receive(:all).and_return([banner])
      helper.banner_viewer.should == ActionController::Base.new.render_to_string(partial: "boss/banners/banner_viewer", locals:{banners: [banner]})
    end
  end
end
