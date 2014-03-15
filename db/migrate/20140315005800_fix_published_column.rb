class FixPublishedColumn < ActiveRecord::Migration
  def change
    remove_column :books, :published_at
    add_column  :books, :published_year, :integer
  end
end
