require "test_helper"

class TasksControllerTest < ActionDispatch::IntegrationTest

  setup do
    @user = users(:one) # Adiciona um usuário de teste
    @list = lists(:one)
    @task = tasks(:one)
    sign_in @user # Faz login com o usuário de teste
  end

  # Testa se a página de índice de tarefas é carregada com sucesso
  test "should get index" do
    get list_tasks_url(@list)
    assert_response :success
  end

  # Testa se a página de nova tarefa é carregada com sucesso
  test "should get new" do
    get new_list_task_url(@list)
    assert_response :success
  end

  # Testa se uma nova tarefa é criada com sucesso
  test "should create task" do
    assert_difference("Task.count") do
      post list_tasks_url(@list), params: { task: { name: @task.name } }
    end

    assert_redirected_to list_task_url(@list, Task.last)
  end

  # Testa se a página de exibição de uma tarefa é carregada com sucesso
  test "should show task" do
    get list_task_url(@list, @task)
    assert_response :success
  end

  # Testa se a página de edição de uma tarefa é carregada com sucesso
  test "should get edit" do
    get edit_list_task_url(@list, @task)
    assert_response :success
  end

  # Testa se uma tarefa é atualizada com sucesso
  test "should update task" do
    patch list_task_url(@list, @task), params: { task: { name: @task.name } }
    assert_redirected_to list_task_url(@list, @task)
  end

  # Testa se o status de conclusão de uma tarefa é alternado com sucesso
  test "should toggle task completion" do
    patch toggle_complete_list_task_url(@list, @task)
    assert_redirected_to list_tasks_url(@list)
    assert_equal !@task.is_completed, @task.reload.is_completed
  end

  # Testa se uma tarefa é destruída com sucesso
  test "should destroy task" do
    assert_difference("Task.count", -1) do
      delete list_task_url(@list, @task)
    end

    assert_redirected_to list_tasks_url(@list)
  end

  private

  # Método auxiliar para fazer login com o usuário de teste
  def sign_in(user)
    post session_path, params: { email_address: user.email_address, password: '12346578' }
  end
end
