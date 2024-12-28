require "test_helper"

class TaskTest < ActiveSupport::TestCase
  # Teste para verificar se a task é válida com todos os atributos necessários
  test "should be valid with valid attributes" do
    list = List.create(name: "Test List")
    task = Task.new(name: "Test Task", list: list)
    assert task.valid?
  end

  # Teste para verificar se a task não é válida sem um nome
  test "should not be valid without a name" do
    list = List.create(name: "Test List")
    task = Task.new(list: list)
    assert_not task.valid?
  end

  # Teste para verificar se a task não é válida sem uma lista associada
  test "should not be valid without a list" do
    task = Task.new(name: "Test Task")
    assert_not task.valid?
  end

  # Teste para verificar se a task não é válida com um nome vazio
  test "should not be valid with an empty name" do
    list = List.create(name: "Test List")
    task = Task.new(name: "", list: list)
    assert_not task.valid?
  end
end
