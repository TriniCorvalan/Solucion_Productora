class AddConcertToGroups < ActiveRecord::Migration[5.2]
  def change
    add_reference :groups, :concert, foreign_key: true
  end
end
