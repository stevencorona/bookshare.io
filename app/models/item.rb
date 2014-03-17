class Item < ActiveRecord::Base
  belongs_to :book, foreign_key: :book_isbn, primary_key: :isbn
  belongs_to :order
end
