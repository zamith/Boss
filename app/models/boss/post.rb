module Boss
  class Post < ActiveRecord::Base
    attr_accessible :body, :start_date, :title
  end
end
