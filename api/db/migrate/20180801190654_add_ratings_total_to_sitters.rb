class AddRatingsTotalToSitters < ActiveRecord::Migration[5.2]
  def change
    add_column :sitters, :ratings_total, :integer, default: 0
  end
end
