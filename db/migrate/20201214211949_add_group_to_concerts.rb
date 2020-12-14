class AddGroupToConcerts < ActiveRecord::Migration[5.2]
  def change
    add_reference :concerts, :group, foreign_key: true
  end
end
