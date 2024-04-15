class CreateCoordinates < ActiveRecord::Migration[7.1]

	def change
		create_table :coordinates do |t|
		t.float :latitude
		t.float :longitude

		t.timestamps
		end
  	end
end
