module Boss
  class Banner < ActiveRecord::Base

    attr_accessible :boss_resource_id, :finish_date, :link, :start_date, :title, :image_attributes

    belongs_to :image, :class_name => "Boss::Resource", :foreign_key => :boss_resource_id
    before_validation :ensure_title_has_a_value
    validates_presence_of :start_date, :image
    validate :finish_date_after_end_date
    accepts_nested_attributes_for :image
    validates_associated :image

    private

    def ensure_title_has_a_value
      if title.nil?
        self.title = I18n::t('banners.default_title')
      end
    end

    def finish_date_after_end_date
      if finish_date && (finish_date < start_date)
        errors.add(:finish_date, "finish date must be after start date")
      end
    end

  end
end
