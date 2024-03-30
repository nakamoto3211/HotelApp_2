class UsersController < ApplicationController
  #searchアクション以外はログインしているか確認する
  before_action :authenticate_user!, except: [:home]

  def home
  end

  def show
    @user = User.find(params[:id])
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])
    if @user.update!(params.require(:user).permit(:name, :icon_image, :introduction))
      flash[:notice] = "プロフィール情報を更新しました"
      redirect_to user_path(id: current_user)
    else
      render "edit"
    end
  end

end
