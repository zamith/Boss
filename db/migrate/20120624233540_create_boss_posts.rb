class CreateBossPosts < ActiveRecord::Migration
  def change
    create_table :boss_posts do |t|
      t.string :title
      t.text :body
      t.datetime :start_date

      t.timestamps
    end
  end
end
