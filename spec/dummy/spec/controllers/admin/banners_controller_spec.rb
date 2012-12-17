require 'spec_helper'

describe Boss::Admin::BannersController do

  set_fixture_class :boss_banners => 'Boss::Banner'
  fixtures :boss_banners

  set_fixture_class :citygate_users => 'Citygate::User'
  fixtures :citygate_users

  context "show" do
    it "should send banner to show view" do
      sign_in_user
      banner = boss_banners(:first)

      get :show, id: banner.id
      assigns(:banner).should == boss_banners(:first)
    end
  end

  context "index" do
    it "Sends all Banners to the index view" do
      sign_in_user
      banners = Boss::Banner.all

      get :index
      assigns(:banners).should == banners
    end
  end

  context "edit" do
    it "should send object to view" do
      sign_in_user
      banner = boss_banners(:first)

      get :edit, id: banner.id
      assigns(:banner).should == boss_banners(:first)
    end

    it "should update banner" do
      # check if updates happens
      sign_in_user
      banner = boss_banners(:first)

      Boss::Banner.should_receive(:find).at_least(:once).and_return(banner) # deve encontrar o object
      banner.should_receive(:update_attributes) # deve ser chamado o metodo :update_attributes

      put :update, id: banner
    end
  end

  context "create" do

    it "should call save method" do
      sign_in_user
      create_banner
      Boss::Banner.should_receive(:new).at_least(:once).and_return(@banner)
      @banner.should_receive(:save)

      post :create, banner: @banner
    end

    it "creates a banner" do
      sign_in_user
      banner = Boss::Banner.new(title: "First Banner - CREATE", link: "http://groupbuddies.com", start_date: "2012-11-1")  
      banner.image = Boss::Resource.create_image fixture_file_upload('/files/computer_0050.jpg', 'image/jpeg')

      expect {
        post :create, banner: banner.attributes
      }.to change{Boss::Banner.count}.by(1)
    end
  end

  context "destroy" do
    it "should remove banner" do
      sign_in_user

      banner = boss_banners(:first)

      expect {
        delete :destroy, id: banner.id
      }.to change{Boss::Banner.count}.by(-1)
    end
  end

end

def sign_in_user
  @user = citygate_users(:admin)
  sign_in @user
end

def create_banner
  @banner = boss_banners(:first)
  @banner.image = Boss::Resource.create_image fixture_file_upload('/files/computer_0050.jpg', 'image/jpeg')
end

