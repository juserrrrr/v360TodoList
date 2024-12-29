class UserMailer < ApplicationMailer
  default from: 'FocusTask <focustaskdev@gmail.com>'

  def welcome_email
    @user = params[:user]
    @session_url = url_for(controller: 'sessions', action: 'new', only_path: false)
    @host_addres = Rails.application.config.action_mailer.default_url_options[:host]
    mail(to: 'gabrielrpg13@gmail.com', subject: 'Welcome to the site!')
  end
end