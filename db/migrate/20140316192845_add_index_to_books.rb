class AddIndexToBooks < ActiveRecord::Migration
  def change
    add_index :books, :isbn
  end
end
