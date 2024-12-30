require "test_helper"

class UserMailerTest < ActionMailer::TestCase
  test "welcome email" do
    user = users(:one)
    mail = UserMailer.with(user: user).welcome_email

    assert_emails 1 do
      mail.deliver_now
    end

    assert_equal ['focustaskdev@gmail.com'], mail.from
    assert_equal [user.email_address], mail.to
    assert_equal 'Welcome to the site!', mail.subject
    assert_match /Welcome to FocusTask, #{user.name}/, mail.body.encoded
  end

end
