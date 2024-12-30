class UsersController < ApplicationController
  # Permitir acesso não autenticado
  allow_unauthenticated_access
  # Redirecionar usuário autenticado
  redirect_authenticated_user

  # GET /users/new
  def new
    # Inicializar um novo usuário
    @user = User.new
  end

  # POST /users ou /users.json
  def create
    # Criar um novo usuário com os parâmetros permitidos
    @user = User.new(user_params)

    respond_to do |format|
      if @user.save
        # Enviar email de boas-vindas de forma assíncrona
        UserMailer.with(user: @user).welcome_email.deliver_later
        # Responder com sucesso na criação do usuário
        format.html { redirect_to new_session_path, notice: "User was successfully created. Please sign in." }
        format.json { render :show, status: :created, location: @user }
      else
        # Responder com erro na criação do usuário
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  private

    # Apenas permitir uma lista de parâmetros confiáveis através de strong parameters
    def user_params
      params.require(:user).permit(:name, :email_address, :password, :password_confirmation)
    end
end
