class SessionsController < ApplicationController

  def new

  end

  def create
    user = User.find_by(email: params[:session][:email].downcase)
    if (user && user.authenticate(params[:session][:password]))
      sign_in user
      redirect_to user
    else
      # Crear mensaje de error y redirigir nuevamente al formulario de autenticación.
      flash.now[:error] = 'Invalid user name or password'
      # Se usa flash.now porque render no cuenta como un request y el flash se queda una
      # etapa más de las deseadas (1)
      render 'new'
    end
  end

  def destroy
  end
end
