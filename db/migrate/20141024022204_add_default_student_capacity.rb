class AddDefaultStudentCapacity < ActiveRecord::Migration
  def change
    change_column :classrooms, :student_capacity, :integer, :default => 30
  end
end
