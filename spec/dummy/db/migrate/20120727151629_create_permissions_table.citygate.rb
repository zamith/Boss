# This migration comes from citygate (originally 20120727143920)
class CreatePermissionsTable < ActiveRecord::Migration
  def change
    create_table :citygate_permissions do |t|
      t.string  :action,            :null => false
      t.string  :subject_class,     :null => false
      t.string  :subject_id
      t.integer :role_id
    end
    
    add_index :citygate_permissions, :role_id
  end
end
