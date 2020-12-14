class CreateGroups < ActiveRecord::Migration[5.2]
  def change
    create_table :groups do |t|
      t.integer :crew
      t.date :debut_date
      t.integer :type_group

      t.timestamps
    end
  end
end
