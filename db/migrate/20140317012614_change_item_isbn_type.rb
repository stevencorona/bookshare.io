class ChangeItemIsbnType < ActiveRecord::Migration
  def change
    change_column :items, :book_isbn, :string
  end
end
