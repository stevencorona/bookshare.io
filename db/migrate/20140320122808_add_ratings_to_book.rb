class AddRatingsToBook < ActiveRecord::Migration
  def change
    add_column :books, :ratings_count,  :integer
    add_column :books, :average_rating, :decimal
  end
end
