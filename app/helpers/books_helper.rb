module BooksHelper

  BOOK_LIMIT = 5

  def amazon_link(book, opts={})
    link_to "View on Amazon", "https://www.amazon.com/gp/product/#{book.isbn}", opts
  end

  def book_cover_image(book, opts={})
    opts[:width]   ||= 150
    opts[:height]  ||= 225
    opts[:crop]    ||= "fill"

    cl_image_tag("#{book.isbn}_cover.jpg", opts)
  end

  def books_left
    BOOK_LIMIT - @order.items.count
  end

  def books_left_nav
    if @order.items.count != 0
      "You've chosen #{@order.items.count}/#{BOOK_LIMIT} books"
    end
  end
end
