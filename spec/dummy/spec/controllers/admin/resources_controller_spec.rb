require 'spec_helper'

describe Boss::Admin::ResourcesController do
  set_fixture_class :boss_posts => 'Boss::Post'
  fixtures :boss_posts

  set_fixture_class :citygate_users => 'Citygate::User'
  fixtures :citygate_users

  let(:user) { citygate_users(:admin) }

  before (:each) do
    Boss::Resource.create_image fixture_file_upload('/files/computer_0050.jpg', 'image/jpeg')
    Boss::Resource.create_image fixture_file_upload('/files/computer_0050.jpg', 'image/jpeg')
    sign_in user
  end

  context "create" do
    it "should list the resources with a limit" do
      RESOURCES["index_limit"] = "1"

      get :index

      assigns(:resources).size.should <= 1
    end
  end

end
