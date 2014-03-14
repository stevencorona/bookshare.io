module BooksHelper
  def amazon_link(book, opts={})
    link_to "View on Amazon", "https://www.amazon.com/gp/product/#{book.isbn}", opts
  end
end
