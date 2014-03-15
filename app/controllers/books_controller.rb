class BooksController < ApplicationController

  protect_from_forgery except: [:create]

  def index
    @books = Book.all
  end

  def show
    @book = Book.find_by_isbn(params[:isbn])
  end

  def create
    @book = Book.new

    # Pull data from OpenLibrary
    data = GoogleBooks.search("isbn:#{params[:isbn]}").first

    @book.title       = data.title
    @book.description = data.description
    @book.pages       = data.page_count
    @book.isbn        = data.isbn_10

    # Good enough for now; Just take the name of the first
    # author.
    @book.author = data.authors

    @book.published_year = data.published_date

    @book.save

    # Upload the image to Cloudinary (TODO: Make this pretty)
    Cloudinary::Uploader.upload("http://images.amazon.com/images/P/#{@book.isbn}.01.LZZZZZZZ.jpg", :public_id => "#{@book.isbn}_cover")

    redirect_to @book

  end

end
