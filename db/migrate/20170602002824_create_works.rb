class CreateWorks < ActiveRecord::Migration
  def change
    create_table :works do |t|
      t.string :title
      t.integer :status, default: 0
      t.integer :special, default: 0
      t.references :category, index: true, foreign_key: true
      t.string :description
      t.text :characteristics
      t.text :data_sheet
      t.text :information
      t.string :external_link
      t.string :slug

      t.timestamps null: false
    end
    add_index :works, :slug, unique: true
  end
end
