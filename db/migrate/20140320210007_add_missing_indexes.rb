class AddMissingIndexes < ActiveRecord::Migration
  def up
    add_index :books, :category_id
    add_index :items, :order_id
    add_index :items, :book_isbn
    add_index :orders, :email

    execute "create index books_title on books using gin(to_tsvector('english', title))"
    execute "create index books_description on books using gin(to_tsvector('english', description))"
  end

  def down
    remove_index :books, :category_id
    remove_index :items, :order_id
    remove_index :items, :book_isbn
    remove_index :orders, :email

    execute "drop index books_title"
    execute "drop index books_description"
  end
end
