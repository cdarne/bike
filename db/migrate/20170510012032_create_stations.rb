class CreateStations < ActiveRecord::Migration[5.1]
  def change
    create_table :stations do |t|
      t.string :name
      t.float :latitude
      t.float :longitude
      t.integer :available_bikes

      t.timestamps
    end
  end
end
