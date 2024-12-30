class PasswordsMailer < ApplicationMailer
  # Método para enviar email de redefinição de senha
  def reset(user)
    @user = user
    # Configura o email com o assunto e o destinatário
    mail(subject: "Reset your password", to: user.email_address)
  end
end
