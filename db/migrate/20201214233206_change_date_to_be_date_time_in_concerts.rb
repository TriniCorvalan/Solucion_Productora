class ChangeDateToBeDateTimeInConcerts < ActiveRecord::Migration[5.2]
  def change
    change_column :concerts, :date, :datetime
  end
end
