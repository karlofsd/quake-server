class CreateFeatures < ActiveRecord::Migration[7.1]

	def change
    create_table :features do |t|
		t.string :external_id
		t.string :title, null: false
		t.float :magnitude
		t.string :mag_type, null: false
		t.string :place, null: false
		t.string :time
		t.boolean :tsunami
		t.string :external_url, null: false

      t.timestamps
    end
  end
end
