class UserMailer < ApplicationMailer

  # Método para enviar email de boas-vindas
  def welcome_email
    @user = params[:user]
    # URL para a página de login
    @session_url = url_for(controller: 'sessions', action: 'new', only_path: false)
    # Endereço do host configurado para o mailer
    @host_addres = Rails.application.config.action_mailer.default_url_options[:host]
    # Configura o email com o destinatário e o assunto
    mail(to: @user.email_address, subject: 'Welcome to the site!')
  end
end