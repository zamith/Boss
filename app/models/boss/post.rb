module Boss
  class Post < ActiveRecord::Base
    include Boss::Pagination
    acts_as_taggable
    
    attr_accessible :body, :published_date, :title, :draft, :category_id
    validates_presence_of :title, :body
    before_validation :ensure_title_has_a_value

    belongs_to :category, :class_name => "Boss::Category"

    protected
      def ensure_title_has_a_value
        if title.nil?
          self.title = I18n::t('posts.default_title')
        end
      end

  end
end
