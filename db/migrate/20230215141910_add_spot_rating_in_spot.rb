class AddSpotRatingInSpot < ActiveRecord::Migration[7.0]
  def change
    add_column :spots, :spot_rating, :integer
  end
end
