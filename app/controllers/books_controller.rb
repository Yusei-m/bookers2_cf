class BooksController < ApplicationController
  def new
    @book = Book.new
  end
  def edit
    @book = Book.find(params[:id])
     if @book.user == current_user
    else
      redirect_to books_path
    end
  end
  
  

  def create
   #@book = current_user.books.new(book_params)

    @book = Book.new(book_params)
    @book.user_id = current_user.id

    if @book.save
       flash[:notice] ="You have created book successfully."
    redirect_to book_path(@book.id)
    else
    @books = Book.all
    render :index
    end
  end

  def update
    @book = Book.find(params[:id])
    if @book.update(book_params)
      flash[:notice] = "You have updated book successfully."
    redirect_to book_path(@book.id)
    
  else
    render :edit
  end
  end
  def index
    @books = Book.all
    @book = Book.new
  end

  def show
    @book = Book.find(params[:id])
    @bok = Book.new
    @book_comment = BookComment.new
  end
  def destroy
    book =  Book.find(params[:id])
    book.destroy
    redirect_to books_path
  end
  private

  def book_params
    params.require(:book).permit(:title, :body)
  end
end
