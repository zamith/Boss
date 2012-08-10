class ChangeStartDateToPublishedDate < ActiveRecord::Migration
  def change
    rename_column :boss_posts, :start_date, :published_date
  end
end
