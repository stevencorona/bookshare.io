class ChangeSkuToIsbn < ActiveRecord::Migration
  def change
    rename_column :books, :sku, :isbn
  end
end
