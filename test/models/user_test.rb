require "test_helper"

class UserTest < ActiveSupport::TestCase
  # Teste para verificar se o usuário é válido com atributos válidos
  test "should be valid with valid attributes" do
    user = User.new(email_address: "user@example.com", password: "password")
    assert user.valid?
  end

  # Teste para verificar se o email é obrigatório
  test "should require an email address" do
    user = User.new(password: "password")
    assert_not user.valid?
    assert_includes user.errors[:email_address], "can't be blank"
  end

  # Teste para verificar se a senha é obrigatória
  test "should require a password" do
    user = User.new(email_address: "user@example.com")
    assert_not user.valid?
    assert_includes user.errors[:password], "can't be blank"
  end

  # Teste para verificar se o email é único
  test "should require a unique email address" do
    user1 = User.create!(email_address: "user@example.com", password: "password")
    user2 = User.new(email_address: "user@example.com", password: "password")
    assert_not user2.valid?
    assert_includes user2.errors[:email_address], "has already been taken"
  end

  # Teste para verificar a normalização do email
  test "should normalize email address" do
    user = User.create!(email_address: " User@Example.com ", password: "password")
    assert_equal "user@example.com", user.email_address
  end

  # Teste para verificar a associação com listas
  test "should have many lists" do
    user = User.new(email_address: "user@example.com", password: "password")
    assert_respond_to user, :lists
  end

  # Teste para verificar a associação com sessões
  test "should have many sessions" do
    user = User.new(email_address: "user@example.com", password: "password")
    assert_respond_to user, :sessions
  end

  # Cleanup after each test
  teardown do
    Task.delete_all
    List.delete_all
    User.delete_all
  end
end
