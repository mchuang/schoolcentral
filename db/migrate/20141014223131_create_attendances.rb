class CreateAttendances < ActiveRecord::Migration
  def change
    create_table :attendances do |t|
      t.integer :student_id
      t.integer :classroom_id
      t.date :date
      t.integer :status

      t.timestamps
    end
  end
end
