class CreateSlides < ActiveRecord::Migration[5.2]
  def change
    create_table :slides do |t|
      t.references :course
      t.string :content
      t.integer :order
      t.timestamps
    end
  end
end
