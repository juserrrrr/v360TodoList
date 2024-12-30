require 'test_helper'

class PasswordsMailerTest < ActionMailer::TestCase
  include Rails.application.routes.url_helpers

  def setup
    @user = users(:one) # Assuming you have a fixture for users
    @host = 'localhost:3000'
    Rails.application.routes.default_url_options[:host] = @host
  end

  test "reset email" do
    mail = PasswordsMailer.reset(@user)
  
    assert_emails 1 do
      mail.deliver_now
    end
  
    assert_equal ['focustaskdev@gmail.com'], mail.from
    assert_equal [@user.email_address], mail.to
    assert_equal 'Reset your password', mail.subject

    # Check plain text part
    assert_match /You can reset your password within the next 15 minutes/, mail.text_part.body.encoded
  
    # Check HTML part
    assert_match /You can reset your password within the next 15 minutes by clicking the button below/, mail.html_part.body.encoded
    assert_match /If you did not request a password reset, please ignore this email./, mail.html_part.body.encoded
    assert_match /All rights reserved to FocusTask © 2025/, mail.html_part.body.encoded
  end
  
end
