class CreateCourses < ActiveRecord::Migration[5.1]
  def change
    create_table :courses do |t|
      t.belongs_to :instructor, index: true
      t.string :name
      t.string :description
      t.string :category
      t.string :subject
      t.integer :student_count
      t.datetime :start_time
      t.datetime :end_time

      t.timestamps
    end
  end
end
