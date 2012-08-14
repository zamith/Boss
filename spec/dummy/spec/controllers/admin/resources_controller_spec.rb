require 'spec_helper'

describe Boss::Admin::ResourcesController do
  set_fixture_class :citygate_users => 'Citygate::User'
  fixtures :citygate_users

  let(:user) { citygate_users(:admin) }

  before (:each) do
    @first = Boss::Resource.create_image fixture_file_upload('/files/computer_0050.jpg', 'image/jpeg')
    @second = Boss::Resource.create_file fixture_file_upload('/files/basketball.pdf', 'application/pdf')
    sign_in user
  end

  context "create" do
    it "should list the resources with a limit" do
      RESOURCES["index_limit"] = "1"

      get :index

      assigns(:resources).size.should <= 1
    end
  end

  context "load" do
    it "should get resources to show in the index with a given offset" do
      get :load, starts_at: 1

      assigns(:resources).first.should == @second
    end
  end

end
