class BooksController < ApplicationController

  protect_from_forgery except: [:create]

  def index
    @books = Book.all
  end

  def show
    @book = Book.find_by_isbn(params[:isbn])
  end

  def create
    loader = BookLoader.new(params[:isbn], cover: :amazon, data: :google)
    loader.publish

    redirect_to loader.book
  end

end
