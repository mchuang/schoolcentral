class AddIdentifierToSchool < ActiveRecord::Migration
  def change
    add_column :schools, :identifier, :string, null: false, unique: true
  end
end
