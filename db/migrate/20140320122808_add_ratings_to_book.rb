class AddRatingsToBook < ActiveRecord::Migration
  def change
    add_column :books, :ratings_count,  :integer, default: 0
    add_column :books, :average_rating, :float,   default: 0.0
  end
end
