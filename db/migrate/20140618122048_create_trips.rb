class CreateTrips < ActiveRecord::Migration
  def change
    create_table :trips do |t|
      t.string :name, null: false
    end
  end
end
