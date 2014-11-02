class CreateEvents < ActiveRecord::Migration
  def change
    create_table :events do |t|
      t.string :name
      t.datetime :startime
      t.datetime :endtime
      t.string :description

      t.timestamps
    end
  end
end
