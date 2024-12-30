class Task < ApplicationRecord
  # Define relacionamento de muitos-para-um com listas
  belongs_to :list
  
  # Validação para garantir a presença do nome da tarefa
  validates :name, presence: true
end
