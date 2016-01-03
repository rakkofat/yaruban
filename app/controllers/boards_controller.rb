class BoardsController < ApplicationController
  before_action :correct_user,   only: [:index, :show]
  before_action :logged_in_user, only: [:index, :show]

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

    def logged_in_user
      unless logged_in?
        flash[:danger] = "Please log in."
        redirect_to root_url
      end
    end

    def correct_user
      @user = User.find_by(id: session[:user_id])
      redirect_to(root_url) unless current_user?(@user)
    end

end
