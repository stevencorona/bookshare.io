class AddCategoryToBook < ActiveRecord::Migration
  def change
    add_column :books, :category_id, :integer
  end
end
