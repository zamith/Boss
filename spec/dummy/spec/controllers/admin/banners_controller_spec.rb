require 'spec_helper'

describe Boss::Admin::BannersController do

  set_fixture_class :boss_banners => 'Boss::Banner'
  fixtures :boss_banners

  set_fixture_class :citygate_users => 'Citygate::User'
  fixtures :citygate_users

  context "create" do
    # TODO: check for size increnment by 1 when save

    it "should call save method" do
      sign_in_user
      create_banner
      Boss::Banner.should_receive(:new).at_least(:once).and_return(@banner)
      @banner.should_receive(:save)

      post :create, banner: @banner
    end

    it "should increnment by 1" do
      before_create_size = Boss::Banner.all.size
      sign_in_user
      create_banner

      Boss::Banner.all.size == (before_create_size+1)
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
