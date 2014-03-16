class BooksController < ApplicationController

  protect_from_forgery except: [:create]

  def index
    @books = Book.all
  end

  def show
    @book = Book.find_by_isbn!(params[:isbn])
  end

  def create
    loader = BookLoader.new(params[:isbn], cover: :amazon, data: :google)
    loader.publish

    redirect_to loader.book
  end

  def claim
    # TODO: Handle user having > 5 books
    @book = Book.find_by_isbn!(params[:isbn])
    session[:books] << @book.isbn
    redirect_to book_path(@book.isbn)
  end

  def unclaim
    session[:books].delete(params[:isbn])
    redirect_to book_path(params[:isbn])
  end

  def search
    @books = Book.text_search(params[:query])
  end

end
