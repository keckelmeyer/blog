class CreateResources < ActiveRecord::Migration
  def change
    create_table :resources do |t|
      t.string :category
      t.string :title
      t.text :link

      t.timestamps null: false
    end
  end
end
