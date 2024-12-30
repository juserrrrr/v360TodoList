class User < ApplicationRecord
  # Adiciona funcionalidades de segurança para senhas
  has_secure_password
  
  # Define relacionamento de um-para-muitos com sessões e listas
  has_many :sessions, dependent: :destroy
  has_many :lists, dependent: :destroy

  # Normaliza o endereço de email removendo espaços e convertendo para minúsculas
  normalizes :email_address, with: ->(e) { e.strip.downcase }

  # Validações para garantir presença e unicidade do endereço de email e presença da senha
  validates :email_address, presence: true, uniqueness: true
  validates :password, presence: true
end
