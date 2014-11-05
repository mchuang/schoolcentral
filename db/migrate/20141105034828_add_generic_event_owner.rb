class AddGenericEventOwner < ActiveRecord::Migration
  def change
    add_column :events, :owner_id, :integer
    add_column :events, :owner_type, :string
  end
end
