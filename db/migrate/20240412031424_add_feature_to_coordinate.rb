class AddFeatureToCoordinate < ActiveRecord::Migration[7.1]
  def change
    add_reference :coordinates, :feature, null: false, foreign_key: true
  end
end
