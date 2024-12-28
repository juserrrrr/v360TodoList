require "test_helper"

class ListsControllerTest < ActionDispatch::IntegrationTest

  setup do
    @list = lists(:one)
    @other_user_list = lists(:two)
    @user = users(:one)
    @other_user = users(:two)
    sign_in_as @user # Faz login com o primeiro usuário de teste
  end

  # Testa se a página de índice é carregada com sucesso e exibe apenas as listas do usuário logado
  test "should get index" do
    get lists_url
    assert_response :success
    assert_select 'h1', text: "My lists"
    assert_select 'div#lists' do
      assert_select "div##{dom_id(@list)}" do
        assert_select 'strong', text: "Name:"
        assert_select 'p', text: /#{@list.name}/ # Procura o nome na lista de listas
      end
      assert_select "div##{dom_id(@other_user_list)}", { count: 0, text: /#{@other_user_list.name}/ } # Não deve exibir a lista de outro usuário
    end
  end

  # Testa se a página de criação de nova lista é carregada com sucesso
  test "should get new" do
    get new_list_url
    assert_response :success
  end

  # Testa se uma nova lista é criada com sucesso
  test "should create list" do
    assert_difference("List.count") do
      post lists_url, params: { list: { name: "New List" } }
    end

    assert_redirected_to list_url(List.last)
  end

  # Testa se a página de exibição de uma lista é carregada com sucesso
  test "should show list" do
    get list_url(@list)
    assert_response :success
  end

  # Testa se a tentativa de exibir a lista de outro usuário é redirecionada com uma mensagem de autorização
  test "should not show other user's list" do
    get list_url(@other_user_list)
    assert_redirected_to lists_url
    assert_equal "You are not authorized to access this list.", flash[:notice]
  end

  # Testa se a página de edição de uma lista é carregada com sucesso
  test "should get edit" do
    get edit_list_url(@list)
    assert_response :success
  end

  # Testa se a tentativa de editar a lista de outro usuário é redirecionada com uma mensagem de autorização
  test "should not get edit for other user's list" do
    get edit_list_url(@other_user_list)
    assert_redirected_to lists_url
    assert_equal "You are not authorized to access this list.", flash[:notice]
  end

  # Testa se uma lista é atualizada com sucesso
  test "should update list" do
    patch list_url(@list), params: { list: { name: "Updated List" } }
    assert_redirected_to list_url(@list)
  end

  # Testa se a tentativa de atualizar a lista de outro usuário é redirecionada com uma mensagem de autorização
  test "should not update other user's list" do
    patch list_url(@other_user_list), params: { list: { name: "Updated List" } }
    assert_redirected_to lists_url
    assert_equal "You are not authorized to access this list.", flash[:notice]
  end

  # Testa se uma lista é destruída com sucesso
  test "should destroy list" do
    assert_difference("List.count", -1) do
      delete list_url(@list)
    end

    assert_redirected_to lists_url
  end

  # Testa se a tentativa de destruir a lista de outro usuário é redirecionada com uma mensagem de autorização
  test "should not destroy other user's list" do
    assert_no_difference("List.count") do
      delete list_url(@other_user_list)
    end

    assert_redirected_to lists_url
    assert_equal "You are not authorized to access this list.", flash[:notice]
  end

  private
  # Método auxiliar para fazer login com um usuário específico
  def sign_in_as(user)
    post session_path, params: { email_address: user.email_address, password: '12346578' }
  end

end
