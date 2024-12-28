require "test_helper"

class UsersControllerTest < ActionDispatch::IntegrationTest
  # Testa se a página de novo usuário é carregada com sucesso
  test "should get new" do
    get new_user_url
    assert_response :success
  end

  # Testa se um novo usuário é criado com parâmetros válidos
  test "should create user" do
    assert_difference('User.count') do
      post users_url, params: { user: { name: 'Test User', email_address: 'test@example.com', password: 'password', password_confirmation: 'password' } }
    end

    assert_redirected_to new_session_path
  end

  # Testa se um novo usuário não é criado com parâmetros inválidos
  test "should not create user with invalid params" do
    assert_no_difference('User.count') do
      post users_url, params: { user: { name: '', email_address: 'invalid', password: 'short', password_confirmation: 'mismatch' } }
    end

    assert_response :unprocessable_entity
  end
end
