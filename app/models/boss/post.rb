module Boss
  class Post < ActiveRecord::Base
    attr_accessible :body, :start_date, :title, :draft
    validates_presence_of :title, :body
    before_validation :ensure_title_has_a_value

    def self.posts_for_index(options = {})
      options.keys.map(&:to_sym)
      options = { no_of_users_in_index: POSTS["no_of_users_in_index"]}.merge options
      
      if options[:starts_at] && options[:starts_at] != 0
        Boss::Post.limit(options[:no_of_users_in_index]).offset(options[:starts_at])
      elsif options[:starts_at] && options[:starts_at] == 0
        []
      else
        Boss::Post.limit(options[:no_of_users_in_index])
      end
    end

    protected
      def ensure_title_has_a_value
        if title.nil?
          self.title = I18n::t('posts.default_title')
        end
      end

  end
end
