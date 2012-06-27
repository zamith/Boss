module Boss
  class Post < ActiveRecord::Base
    attr_accessible :body, :start_date, :title
    validates_presence_of :title
  end
end
