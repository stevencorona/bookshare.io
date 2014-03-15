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
    @book.isbn = params[:isbn]

    # Pull data from OpenLibrary
    data = GoogleBooks.search("isbn:#{@book.isbn}").first

    @book.title       = data.title
    @book.description = data.description
    @book.pages       = data.page_count

    # Good enough for now; Just take the name of the first
    # author.
    @book.author = data.authors

    @book.published_year = data.published_date

    @book.save

    redirect_to @book

  end

end
