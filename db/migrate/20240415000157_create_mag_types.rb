class CreateMagTypes < ActiveRecord::Migration[7.1]
  def change
    create_table :mag_types do |t|
      t.string :symbol
      t.string :label

      t.timestamps
    end
  end
end
