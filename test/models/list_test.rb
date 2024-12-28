require "test_helper"

class ListTest < ActiveSupport::TestCase
  def setup
    @user = User.create!(email_address: "test@example.com", password: "password")
    @list = List.new(name: "Test List", user: @user)
  end

  # Testa se a lista é válida com atributos válidos
  test "should be valid" do
    assert @list.valid?
  end

  # Testa se a lista é inválida sem um nome
  test "name should be present" do
    @list.name = "   "
    assert_not @list.valid?
  end

  # Testa se a lista pertence a um usuário
  test "should belong to user" do
    assert_equal @user, @list.user
  end

  # Testa se a lista possui muitas tarefas
  test "should have many tasks" do
    assert_respond_to @list, :tasks
  end

  # Testa se as tarefas associadas são destruídas quando a lista é destruída
  test "should destroy associated tasks" do
    @list.save
    @list.tasks.create!(name: "Test Task")
    assert_difference 'Task.count', -1 do
      @list.destroy
    end
  end
end
