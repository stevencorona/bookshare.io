module BooksHelper

  BOOK_LIMIT = 5

  def amazon_link(book, opts={})
    link_to "View on Amazon", "https://www.amazon.com/gp/product/#{book.isbn}", opts
  end

  def book_cover_image(book, opts={})
    opts[:width]   ||= 201
    opts[:height]  ||= 300
    opts[:crop]    ||= "fill"
    opts[:gravity] ||= "north"

    cl_image_tag("#{book.isbn}_cover.jpg", opts)
  end

  def books_left
    BOOK_LIMIT - @order.items.count
  end
end
