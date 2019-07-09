class CreateCourses < ActiveRecord::Migration[5.2]
  def change
    create_table :courses do |t|
      t.string :title
      t.integer :minutes
      t.boolean :published
      t.timestamps
    end
  end
end
