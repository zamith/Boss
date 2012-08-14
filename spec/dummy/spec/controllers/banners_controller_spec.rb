require 'spec_helper'

describe Boss::PostsController do
  set_fixture_class :boss_banners => 'Boss::Banner'
  fixtures :boss_banners

  let(:banner) { boss_banners(:gb) }

  set_fixture_class :citygate_users => 'Citygate::User'
  fixtures :citygate_users

  let(:user) { citygate_users(:admin) }

  before (:each) do
    session.clear
    sign_in user
  end

  context "index" do
    it "should return the banners to show in the viewer" do
      get :index

      assigns(:banners).should == [banner]
    end
  end

end
