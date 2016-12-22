class CreateApplications < ActiveRecord::Migration[5.0]
  def change
    create_table :applications do |t|
      t.string :title, null: false, default: ""
      t.string :url, null: false, default: ""
      t.belongs_to :user, foreign_key: true

      t.timestamps
    end
    
    add_index :applications, :url, unique: true
  end
end
