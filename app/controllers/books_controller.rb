class BooksController < ApplicationController

 def index
  @user = current_user
  @book = Book.new
  @books = Book.all
 end

 def create
  @book = Book.new(book_params)
  @book.user_id = current_user.id
  if @book.save
   flash[:complete]="You have creatad book successfully."
   flash[:notice]="You have creatad book successfully."
   redirect_to book_path(@book)
  else
      @user = current_user
  end

 def show
  @newbook = Book.new
  @book = Book.find(params[:id])
  @user = @book.user
 end


 def edit
  @book = Book.find(params[:id])
  if @book.user == current_user
     render "edit"
  else
     redirect_to books_path
  end
 end


 def update
  @book = Book.find(params[:id])
  @book.user_id = current_user.id
  if @book.update(book_params)
     flash[:complete]="Book was successfully updated."
     flash[:notice]="Book was successfully updated."
     redirect_to book_path(@book.id)
  else
      render :edit
  end
 end


 def destroy
  @book = Book.find(params[:id])
  if @book.destroy
     flash[:complete]="Book was successfully destroyed."
     flash[:notice]="Book was successfully destroyed."
     redirect_to books_path
  end

  private
    def book_params
      params.require(:book).permit(:title, :body)
    end
 end