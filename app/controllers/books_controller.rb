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
    data = Openlibrary::Data.find_by_isbn(@book.isbn)

    @book.title = data.title
    @book.pages = data.pages

    # Good enough; Concatonate the subtitle onto the title
    unless data.subtitle.nil?
      @book.title += ": #{data.subtitle}"
    end

    # Good enough for now; Just take the name of the first
    # author.
    @book.author = data.authors[0]["name"]

    @book.save

    redirect_to @book

  end

end
