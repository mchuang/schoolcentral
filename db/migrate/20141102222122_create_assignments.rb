class CreateAssignments < ActiveRecord::Migration
  def change
    create_table :assignments do |t|
      t.integer :teacher_id
      t.integer :classroom_id
      t.integer :max_points
      t.string :name
      t.string :description
      t.datetime :due

      t.timestamps
    end
  end
end
