class BooksController < ApplicationController

  BOOKS_PER_PAGE=32

  respond_to :html, :json
  protect_from_forgery except: [:create]

  def index
    @books = Book.where(status: :avaliable).order("(ratings_count * average_rating) desc").page(params[:page]).per_page(BOOKS_PER_PAGE)
  end

  def category
    @category = Category.find(params[:id])
    @books    = @category.books.where(status: :avaliable).page(params[:page]).per_page(BOOKS_PER_PAGE)
    render :index
  end

  def categories
    @categories = Category.all
  end

  def show
    @book = Book.find_by_isbn!(params[:isbn])
  end

  def create

    # TODO: Move token auth to a helper
    if params[:token].nil? || params[:token] != ENV['SECRET_TOKEN']
      return render status: 401, nothing: true
    end

    loader = BookLoader.new(params[:isbn], cover: :amazon, data: :google)
    loader.publish

    respond_with loader.book
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
