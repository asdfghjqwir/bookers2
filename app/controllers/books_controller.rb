class BooksController < ApplicationController
  before_action :ensure_correct_user, only: [:edit, :update, :destroy]
  
  def index
    @books=Book.all
    @user=current_user
    @book=Book.new
  end

  def show
    @book=Book.find(params[:id])
    @new_book=Book.new
    @user=@book.user
  end
  
  
  def create
    @book=current_user.books.new(book_params)
    if @book.save
      flash[:notice] = "You have created book successfully."
      redirect_to book_path(@book)
    else
      @books=Book.all
      @user=current_user
      render :index
    end
  end
  
  
  def edit
    @book=Book.find(params[:id])
    unless @book.user==current_user
    redirect_to books_path
  end
end
  
  
  def update
    @book=Book.find(params[:id])
    if @book.update(book_params)
      flash[:notice] = "You have updated book successfully."
      redirect_to book_path(@book)
    else
      render :edit
    end
  end
  
  
  def destroy
    @book=Book.find(params[:id])
    if @book.user==current_user
      @book.destroy
      flash[:notice] = "You have destroyed book successfully."
      redirect_to books_path
    end
  end
  
   private
   
   def book_params
     params.require(:book).permit(:title, :body)
   end
   
   def ensure_correct_user
     @book=Book.find(params[:id])
     unless @book.user==current_user
       redirect_to books_path
     end
   end
 end
