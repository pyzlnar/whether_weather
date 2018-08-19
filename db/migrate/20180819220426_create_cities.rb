class CreateCities < ActiveRecord::Migration[5.2]
  def change
    create_table :cities do |t|
      t.string :name
      t.integer :open_weather_id, index: true
      t.timestamps
    end
  end
end
