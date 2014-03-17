class ChangeItemToIsbn < ActiveRecord::Migration
  def change
    rename_column :items, :book_id, :book_isbn
  end
end
