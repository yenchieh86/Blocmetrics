class CreateEvents < ActiveRecord::Migration[5.0]
  def change
    create_table :events do |t|
      t.string :name, null: false, default: ""
      t.belongs_to :application, foreign_key: true
      
      t.timestamps
    end
  end
end
