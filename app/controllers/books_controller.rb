class BooksController < ApplicationController

  protect_from_forgery except: [:create]

  def index
    @books = Book.where(status: :avaliable).all
  end

  def category
    @category = Category.find(params[:id])
    @books    = @category.books.where(status: :avaliable).all
    render :index
  end

  def categories
    @categories = Category.all
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
    @book = Book.find_by_isbn!(params[:isbn])
    @order.items << Item.new(book_isbn: @book.isbn)
    redirect_to book_path(@book.isbn)
  end

  def unclaim
    @item = @order.items.where(book_isbn: params[:isbn]).first
    @item.delete
    redirect_to book_path(params[:isbn])
  end

  def search
    @books = Book.text_search(params[:query])
  end

end
