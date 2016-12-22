class AddSlugToApplications < ActiveRecord::Migration[5.0]
  def change
    add_column :applications, :slug, :string
    add_index :applications, :slug, unique: true
  end
end
