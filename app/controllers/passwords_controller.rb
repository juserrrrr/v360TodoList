class PasswordsController < ApplicationController
  # Permitir acesso não autenticado
  allow_unauthenticated_access
  # Configurar callback para definir o usuário pelo token apenas para as ações edit e update
  before_action :set_user_by_token, only: %i[ edit update ]

  def new
    # Ação para exibir o formulário de solicitação de redefinição de senha
  end

  def create
    # Encontrar o usuário pelo endereço de email fornecido
    if user = User.find_by(email_address: params[:email_address])
      # Enviar email de redefinição de senha de forma assíncrona
      PasswordsMailer.reset(user).deliver_later
    end

    # Redirecionar com mensagem de sucesso (independente de encontrar o usuário ou não)
    redirect_to new_session_path, notice: "Password reset instructions sent (if user with that email address exists)."
  end

  def edit
    # Ação para exibir o formulário de redefinição de senha
  end

  def update
    # Atualizar a senha do usuário com os parâmetros permitidos
    if @user.update(params.permit(:password, :password_confirmation))
      redirect_to new_session_path, notice: "Password has been reset."
    else
      redirect_to edit_password_path(params[:token]), alert: "Passwords did not match."
    end
  end

  private
    # Definir o usuário pelo token de redefinição de senha
    def set_user_by_token
      @user = User.find_by_password_reset_token!(params[:token])
    rescue ActiveSupport::MessageVerifier::InvalidSignature
      redirect_to new_password_path, alert: "Password reset link is invalid or has expired."
    end
end
