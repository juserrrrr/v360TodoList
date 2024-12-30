class ApplicationMailer < ActionMailer::Base
  # Define o endereço de email padrão para os emails enviados
  default from: 'FocusTask <focustaskdev@gmail.com>'
  # Define o layout padrão para os emails
  layout "mailer"
end
