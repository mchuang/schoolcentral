class AddUsersAndClassroomsToSchool < ActiveRecord::Migration
  def change
    add_column :users, :school_id, :integer
    add_column :classrooms, :school_id, :integer
  end
end
