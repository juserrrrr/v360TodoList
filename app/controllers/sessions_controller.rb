class SessionsController < ApplicationController
  # Redirecionar usuário autenticado apenas para as ações new e create
  redirect_authenticated_user only: %i[ new create ]
  # Permitir acesso não autenticado apenas para as ações new e create
  allow_unauthenticated_access only: %i[ new create ]
  # Limitar a taxa de requisições para a ação create
  rate_limit to: 10, within: 3.minutes, only: :create, with: -> { redirect_to new_session_url, alert: "Try again later." }

  def new
    # Ação para exibir o formulário de login
  end

  def create
    # Permitir apenas parâmetros específicos
    permitted_params = params.permit(:email_address, :password, :authenticity_token, :commit)
    # Autenticar o usuário com os parâmetros fornecidos
    if user = User.authenticate_by(permitted_params.slice(:email_address, :password))
      # Iniciar uma nova sessão para o usuário autenticado
      start_new_session_for user
      redirect_to after_authentication_url
    else
      # Redirecionar com mensagem de erro se a autenticação falhar
      redirect_to new_session_path, alert: "Try another email address or password."
    end
  end

  def destroy
    # Terminar a sessão do usuário
    terminate_session
    redirect_to new_session_path
  end
end
