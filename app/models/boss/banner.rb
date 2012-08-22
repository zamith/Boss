module Boss
  class Banner < ActiveRecord::Base
    attr_accessible :boss_resource_id, :finish_date, :link, :start_date, :title

    belongs_to :image, :class_name => "Boss::Resource", :foreign_key => :boss_resource_id

    accepts_nested_attributes_for :image
  end
end