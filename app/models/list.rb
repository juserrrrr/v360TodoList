class List < ApplicationRecord
  # Define relacionamento de um-para-muitos com tarefas e muitos-para-um com usuários
  has_many :tasks, dependent: :destroy
  belongs_to :user
  
  # Validação para garantir a presença do nome da lista
  validates :name, presence: true
end
