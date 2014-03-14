class BooksController < ApplicationController
  def index
    @books = Book.all
  end

  def show
    @book = Book.find_by_isbn(params[:isbn])
  end

end
