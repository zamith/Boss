class AddExtensionColumnToResources < ActiveRecord::Migration
  def change
    add_column :boss_resources, :extension, :string
    add_index  :boss_resources, :extension
    
    remove_index :boss_resources, :resource_content_type
  end
end
