require 'spec_helper'

describe Boss::Banner do
  set_fixture_class :boss_banners => 'Boss::Banner'
  fixtures :boss_banners

  let(:a_banner) { boss_banners(:second) }

  context 'save' do
    it "should have a default value for the title" do
      banner = Boss::Banner.create

      banner.title.should_not be_nil
    end

    it "should have finish_date after start_date" do
      banner = boss_banners(:wrong_date)

      banner.should_not be_valid
    end

  end

end
