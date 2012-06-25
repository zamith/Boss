# This migration comes from citygate (originally 20120303195103)
class AddNameToUsers < ActiveRecord::Migration
  def change
    add_column :citygate_users, :name, :string
  end
end
