class BoardsController < ApplicationController

  def index
    @board = Board.new
    @user = User.find_by(id: session[:user_id])
    @boards = Board.where(user_id: session[:user_id])
  end

  def show
    @board = Board.find(params[:id])
  end

  def new
    @board = Board.new
  end

  def create
    @board = Board.new(board_params)
    @board.user_id = session[:user_id]

    if @board.save
      flash.notice = "New board created!"
      redirect_to boards_path
    else
      flash.notice = @board.errors.full_messages.join(". ")
      redirect_to boards_path
    end
  end

  private

    def board_params
      params.require(:board).permit(:name)
    end

end
