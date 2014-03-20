class BookLoader

  attr_reader :book

  def initialize(isbn, opts)
    opts[:cover] ||= :amazon
    opts[:data]  ||= :google

    @book = Book.new
    @isbn = isbn
  end

  def publish
    book_data
    book_cover

    @book.save
  end

  def book_data
    data = GoogleBooks.search("isbn:#{@isbn}").first
    @book.title          = data.title
    @book.description    = data.description
    @book.pages          = data.page_count
    @book.isbn           = data.isbn_10 || @isbn
    @book.author         = data.authors
    @book.published_year = data.published_date

    book_category(data.categories)
  end

  def book_category(category)
    @category = Category.where(name: category).first

    unless @category
      @category = Category.create(name: category)
    end

    @book.category = @category

  end

  def book_cover
    url = "http://images.amazon.com/images/P/#{@book.isbn}.01.LZZZZZZZ.jpg"
    upload_book_cover(url)
  end

  def upload_book_cover(url)
    Cloudinary::Uploader.upload(url, public_id: "#{@book.isbn}_cover")
  end

end
