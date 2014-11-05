class UpdateDatabaseValidations < ActiveRecord::Migration
  def change
    change_column :assignments, :teacher_id, :integer, null: false
    change_column :assignments, :classroom_id, :integer, null: false
    change_column :assignments, :name, :string, null: false
    change_column :assignments, :due, :datetime, null: false

    change_column :submissions, :assignment_id, :integer, null: false
    change_column :submissions, :student_id, :integer, null: false
  end
end
