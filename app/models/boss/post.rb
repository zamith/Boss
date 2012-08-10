module Boss
  class Post < ActiveRecord::Base
    include Boss::Pagination

    attr_accessible :body, :start_date, :title, :draft
    validates_presence_of :title, :body
    before_validation :ensure_title_has_a_value

    protected
      def ensure_title_has_a_value
        if title.nil?
          self.title = I18n::t('posts.default_title')
        end
      end

  end
end
