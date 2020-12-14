class CreateConcerts < ActiveRecord::Migration[5.2]
  def change
    create_table :concerts do |t|
      t.string :place
      t.integer :attendance
      t.integer :duration
      t.date :date

      t.timestamps
    end
  end
end
