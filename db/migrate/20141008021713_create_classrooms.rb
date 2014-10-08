class CreateClassrooms < ActiveRecord::Migration
  def change
    create_table :classrooms do |t|
      t.string :name
      t.datetime :time
      t.string :location
      t.string :description
      t.integer :student_capacity

      t.timestamps
    end
  end
end
