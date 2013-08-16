class UsersController < ApplicationController
  def new
    @user = User.new
  end

  def show
    @user = User.find(params[:id])
  end

  def create
    @user = User.new(user_params)
    if @user.save
    else
      render 'new'
    end
  end

  private
    # Nuevo método que ofrece más seguridad, solo usar para la creación los
    # parámetros explícitamente permitidos. Evitar por ejemplo que se envíe is_admin=1
    def user_params
      params.require(:user).permit(:name, :email, :password, :password_confirmation)
    end
end
