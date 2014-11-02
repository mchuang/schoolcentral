class CreateSubmissions < ActiveRecord::Migration
  def change
    create_table :submissions do |t|
      t.string :filename
      t.integer :grade
      t.integer :assignment_id
      t.integer :student_id

      t.timestamps
    end
  end
end
