class CreateBanners < ActiveRecord::Migration
  def change
    create_table :boss_banners do |t|
      t.references :boss_resource
      t.date       :finish_date
      t.string     :link
      t.date       :start_date
      t.string     :title
    end
  end
end
