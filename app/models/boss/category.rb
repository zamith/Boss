module Boss
  class Category < ActiveRecord::Base
    include Boss::Pagination

    attr_accessible :name
  end
end