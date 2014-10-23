class RemoveUselessUserIdField < ActiveRecord::Migration
  def change
    remove_column :admins, :user_id
    remove_column :teachers, :user_id
    remove_column :students, :user_id
  end
end
